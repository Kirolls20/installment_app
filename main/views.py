from django.shortcuts import render,redirect
from django.urls import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView,TemplateView
from .models import Customer, Loan, Installment
from .forms import CustomerForm
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.contrib.auth import login, authenticate, logout
from django.contrib import messages

# Login User Authentication 
def login_user(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            messages.success(request, 'You have successfully logged in')
            return redirect('home')
        else:
            messages.error(request, 'Invalid username or password')
            return render(request, 'base/login.html', {'error': 'Invalid Credentials'})
    return render(request, 'base/login.html')


def logout_user(request):
    logout(request)
    messages.success(request, 'You have successfully logged out')
    return redirect('login')
class ClientHomeView(LoginRequiredMixin, TemplateView):
    template_name = 'main/client_home.html'

class HomeView(TemplateView):
    template_name = 'base/test.html'

class ClientListView(LoginRequiredMixin, ListView):
    template_name = 'main/client_list.html'
    model = Customer
    context_object_name = 'clients'

class CustomerCreateView(LoginRequiredMixin,SuccessMessageMixin, CreateView):
    template_name = 'main/customer_form.html'
    model = Customer
    form_class = CustomerForm
    success_message = 'Client created successfully'
    success_url = reverse_lazy('client_list')
