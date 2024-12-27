from django import forms
from .models import Customer, Loan, Installment

class CustomerForm(forms.ModelForm):
    class Meta:
        model = Customer
        fields = ['name','national_id','phone_number','email','address']

        