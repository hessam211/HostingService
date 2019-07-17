from django.contrib import admin
from django.urls import path, include
from .views import login_form, login_view, admin_panel, user_view, user_update, user_update_form, logout_form




urlpatterns = [
    path('', login_view, name='login'),
    path('login-form', login_form, name='login-form'),
    path('admin-panel/', admin_panel, name='admin-panel'),
    path('admin-panel/profile', user_view, name='profile_list'),
    path('admin-panel/profile/<int:pk>/', user_update, name='user-update'),
    path('admin-panel/profile/update/<int:pk>/', user_update_form, name='user-update-form'),
    path('logout', logout_form, name='logout')
]
