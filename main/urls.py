from django.urls import path
from . import views


urlpatterns = [
    # Authentication urls
    path('login/', views.login_user, name='login'),
    path('logout/', views.logout_user, name='logout'),
    path('', views.HomeView.as_view(), name='home'),
    path('clinet/home', views.ClientHomeView.as_view(), name='client_home'),
    path('client/list', views.ClientListView.as_view(), name='client_list'),
    path('client/create', views.CustomerCreateView.as_view(), name='client_create'),


]