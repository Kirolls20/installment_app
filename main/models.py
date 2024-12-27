from django.db import models

class Customer(models.Model):
    name = models.CharField(max_length=122)
    national_id = models.CharField(max_length=20,unique=True, db_index=True)
    phone_number = models.CharField(max_length=20)
    email = models.EmailField()
    address = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        db_table = 'Customer'
    def __str__(self):
        return self.name
    

class Loan(models.Model):
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    item = models.CharField(max_length=255,null=True,blank=True)
    amount = models.DecimalField(max_digits=10, decimal_places=2) # what the customer is borrowing or take out
    interest_rate = models.DecimalField(max_digits=5, decimal_places=2)
    duration = models.IntegerField() # 12 months or 24 months or 36 months ...
    total_installments = models.DecimalField(max_digits=10, decimal_places=2)
    start_date = models.DateField()
    end_date = models.DateField()
    status = models.CharField(max_length=20,default='active')
    created_at = models.DateTimeField(auto_now_add=True)
   
    class Meta:
        db_table = 'Loan'

    def __str__(self):
        return self.item + ' - ' + self.customer_id.name
    
    
class Installment(models.Model):
    loan_id = models.ForeignKey(Loan, on_delete=models.CASCADE,related_name='installments', db_index=True)
    installment_number = models.IntegerField()
    installment_amount = models.DecimalField(max_digits=10, decimal_places=2)
    installment_date = models.DateField()
    paid = models.BooleanField(default=False)
    payment_method = models.CharField(max_length=40)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        db_table = 'Installment'

    def __str__(self):
        return self.loan_id.customer_id.name
    
