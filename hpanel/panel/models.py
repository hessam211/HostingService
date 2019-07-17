from django.db import models
from django.contrib.auth.models import User
# Create your models here.


class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    is_admin = models.BooleanField(default=False)
    domain_name = models.CharField(max_length=20, blank=True, null=True)
    capacity = models.DecimalField(max_digits=5, decimal_places=1)

    def __str__(self):
        return f"{self.user.username} Profile"