from django.forms import ModelForm
from .models import User, Profile


class UserForm(ModelForm):
    class Meta:
        model = User
        fields = ('username', 'password', 'email')


class ProfileForm(ModelForm):
    class Meta:
        model = Profile
        fields = ('domain_name', 'capacity')