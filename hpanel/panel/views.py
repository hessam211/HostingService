from django.shortcuts import render, HttpResponse
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import login, authenticate
# Create your views here.


def login_view(request):
    form = AuthenticationForm()
    return render(request, 'index.html', {'form': form})


def login_form(request):
    form = AuthenticationForm(data=request.POST)
    if form.is_valid():       # username = form.cleaned_data.get('username')
        username = form.cleaned_data.get('username')
        password = form.cleaned_data.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
        else:
            return HttpResponse("user doesn't exist")
        return HttpResponse('u are logged in')
    else:
        return HttpResponse('not valid form')
