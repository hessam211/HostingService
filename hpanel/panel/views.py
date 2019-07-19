from django.shortcuts import render, HttpResponse, redirect, Http404
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import login, authenticate, logout
from .models import Profile, User
from django.contrib.auth.decorators import login_required
from .forms import UserForm, ProfileForm, PasswordChange
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView, UpdateView, DeleteView
from django.contrib.auth.mixins import LoginRequiredMixin
# Create your views here.


def check_admin(user_obj):
    q = Profile.objects.filter(is_admin=True)
    for q1 in q:
        if user_obj == q1.user:
            return True
    return False


def login_view(request):
    if request.user.is_authenticated:
        if check_admin(request.user):
            return redirect('admin-panel')
        else:
            return redirect('user-panel')
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
        if check_admin(request.user):
            return redirect('admin-panel')
        else:
            return redirect('user-panel')
    else:
        return redirect('login')


@login_required(login_url='login')
def admin_panel(request):
    if check_admin(request.user):
        return render(request, 'admin-panel.html')
    else:
        return HttpResponse("<h1>You are not Authorized For This Page</h1>")
    #return HttpResponse('not admin')
    #return render(request, 'admin-panel.html', {'q2': q2})


@login_required(login_url='login')
def user_view(request):
    q1 = User.objects.all()
    if check_admin(request.user):
        return render(request, 'profile_list.html', {'q1': q1})
    else:
        return HttpResponse("<h1>You are not Authorized For This Page</h1>")

@login_required(login_url='login')
def user_update(request, pk):
    if check_admin(request.user):
        q1 = User.objects.filter(id=pk)
        form = UserForm(instance=q1[0])
        form_profile = ProfileForm(instance=q1[0].profile)
        return render(request, 'profile_detail.html', {'q1': q1, 'form': form, 'form_profile': form_profile})
    else:
        return HttpResponse("<h1>You are not Authorized For This Page</h1>")

@login_required(login_url='login')
def user_update_form(request, pk):
    if check_admin(request.user):
        q1 = User.objects.filter(id=pk)
        form = UserForm(request.POST, instance=q1[0])
        form_profile = ProfileForm(request.POST, instance=q1[0].profile)
        if form.is_valid() and form_profile.is_valid():       # username = form.cleaned_data.get('username')
            b = form.save()
            form_profile.save()
            b.set_password(request.POST.get('password'))
            b.save()
            return redirect("profile_list")
        else:
            return render(request, 'admin-panel.html')
    else:
        return HttpResponse("<h1>You are not Authorized For This Page</h1>")


@login_required(login_url='login')
def login_as_user_form(request, pk):
    if check_admin(request.user):
        if request.method == "POST":
            q1 = User.objects.filter(id=pk)
            logout(request)
            login(request, q1[0])
            return redirect("user-panel")
    else:
        return HttpResponse("<h1>You are not Authorized For This Page</h1>")


@login_required(login_url='login')
def logout_form(request):
    if request.method == "POST":
        logout(request)
    return redirect('login')


from .forms import UserCreateForm, ProfileCreateForm
@login_required(login_url='login')
def user_create(request):
    if check_admin(request.user):
        form = UserCreateForm()
        form_profile = ProfileCreateForm()
        return render(request, 'profile_creation.html', {'form': form, 'form_profile': form_profile})
    else:
        return HttpResponse("<h1>You are not Authorized For This Page</h1>")


@login_required(login_url='login')
def user_create_form(request):
    if check_admin(request.user):
        if request.method == "POST":
            #q1 = User.objects.filter(id=pk)
            form = UserCreateForm(request.POST)
            if form.is_valid():
               b = form.save()
            else:
                return HttpResponse('Error When Saving')
            #q = b.objects.all()
            q = User.objects.filter(username=request.POST.get('username'))
            c = Profile.objects.filter(user=q[0])
            d = c[0]
            d.domain_name = request.POST.get('domain_name')
            if request.POST.get('is_admin') == 'true' or request.POST.get('is_admin') == 'True':
                d.is_admin = "True"
            else:
                d.is_admin = "False"
            d.capacity = request.POST.get('capacity')
            d.save()
            #q = User.objects.filter(username=form.cleaned_data.get('username'))
            #form_profile = ProfileCreateForm(request.POST, instance=q[0])
            #form_profile.user = b.id
            #form_profile.domain_name = request.POST.get('domain_name')
            #form_profile.is_admin = request.POST.get('is_admin')
            #form_profile.capacity = request.POST.get('capacity')
            #form_profile.is_admin = "False"

            #if form_profile.is_valid():# and form.is_valid():       # username = form.cleaned_data.get('username')
            #    form.save()
            #form_profile.save()
            #
            #else:
                #return redirect('admin-panel')
                #m = form.cleaned_data.get('username') + form.cleaned_data.get('password') + form.cleaned_data.get('email')
                #m = m + form_profile.cleaned_data.get('domain_name') + form_profile.cleaned_data.get('capacity')
                #m = m + request.POST.get('domain_name') + str(request.POST.get('is_admin')) + request.POST.get('capacity')
            return redirect("profile_list")
        else:
            return HttpResponse("request is not post")
    else:
        return HttpResponse("<h1>You are not Authorized For This Page</h1>")


@login_required(login_url='login')
def user_panel(request):
    if check_admin(request.user):
        return HttpResponse("<h1>You are not Authorized For This Page</h1>")
    else:
        return render(request, 'user_panel.html')


@login_required(login_url='login')
def change_password(request):
    if check_admin(request.user):
        return HttpResponse("<h1>You are not Authorized For This Page</h1>")
    else:
        form = PasswordChange(instance=request.user)
        return render(request, 'user_password.html', {'form': form})


@login_required(login_url='login')
def change_password_form(request):
    if check_admin(request.user):
        return HttpResponse("<h1>You are not Authorized For This Page</h1>")
    else:
        form = PasswordChange(request.POST, instance=request.user)
        if form.is_valid() and request.POST.get('password') == request.POST.get('pass2'):
            b = form.save()
            b.set_password(request.POST.get('password'))
            b.save()
            return redirect("login")
        else:
            return HttpResponse("wrong move")
