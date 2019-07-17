from django.contrib import admin
from django.urls import path, include
from .views import login_form, login_view




urlpatterns = [
    path('', login_view, name='login'),
    path('login-form', login_form, name='login-form')
]
