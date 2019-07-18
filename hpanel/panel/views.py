from django.shortcuts import render, HttpResponse, redirect
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import login, authenticate, logout
from .models import Profile, User
from django.contrib.auth.decorators import login_required
from .forms import UserForm, ProfileForm
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView, UpdateView, DeleteView
from django.contrib.auth.mixins import LoginRequiredMixin
# Create your views here.


def login_view(request):
    if request.user.is_authenticated:
        return redirect('admin-panel')
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
        return redirect('admin-panel')
    else:
        return render(request, 'admin-panel.html')


@login_required(login_url='login')
def admin_panel(request):
    q2 = Profile.objects.filter(is_admin=True)
    use = request.user
    #for q in q2:
    #    if use == q.user:
    return render(request, 'admin-panel.html')

    #return HttpResponse('not admin')
    #return render(request, 'admin-panel.html', {'q2': q2})


@login_required(login_url='login')
def user_view(request):
    q2 = Profile.objects.filter(is_admin=True)
    use = request.user
    q1 = User.objects.all()
    #for q in q2:
    #    if use == q.user:
    return render(request, 'profile_list.html', {'q1': q1})
    #return HttpResponse('You are Not admin')


@login_required(login_url='login')
def user_update(request, pk):
    q1 = User.objects.filter(id=pk)
    form = UserForm(instance=q1[0])
    form_profile = ProfileForm(instance=q1[0].profile)
    return render(request, 'profile_detail.html', {'q1': q1, 'form': form, 'form_profile': form_profile})

@login_required(login_url='login')
def user_update_form(request, pk):
    q1 = User.objects.filter(id=pk)
    form = UserForm(request.POST, instance=q1[0])
    form_profile = ProfileForm(request.POST, instance=q1[0].profile)
    if form.is_valid() and form_profile.is_valid():       # username = form.cleaned_data.get('username')
        form.save()
        form_profile.save()
        return redirect("profile_list")
    else:
        return render(request, 'admin-panel.html')


@login_required(login_url='login')
def login_as_user_form(request, pk):
    if request.method == "POST":
        q1 = User.objects.filter(id=pk)
        logout(request)
        login(request, q1[0])
        return redirect("admin-panel")


@login_required(login_url='login')
def logout_form(request):
    if request.method == "POST":
        logout(request)
    return redirect('login')


from .forms import UserCreateForm, ProfileCreateForm
@login_required(login_url='login')
def user_create(request):
    #q1 = User.objects.filter(id=pk)
    form = UserCreateForm()
    form_profile = ProfileCreateForm()
    return render(request, 'profile_creation.html', {'form': form, 'form_profile': form_profile})

@login_required(login_url='login')
def user_create_form(request):
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


@login_required(login_url='login')
def user_panel(request):
    q2 = Profile.objects.filter(is_admin=False)
    use = request.user
    for q in q2:
        if use == q.user:
            return render(request, 'user_panel.html')