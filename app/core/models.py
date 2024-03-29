"""
Database models
"""

from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin


class UserManager(BaseUserManager):
    """Manager for user"""

    def create_user(self, email, password=None, **extra_fields):  # automatically adapts keyword args
        """Create, save and return new user"""
        if not email:
            raise ValueError('User must have an email address!')
        user = self.model(email=self.normalize_email(email), **extra_fields)  # basically creating a new user object
        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, email, password):
        """Create and return super user"""
        user = self.create_user(email, password)
        user.is_staff = True
        user.is_superuser = True  # Field provided by PermissionsMixin
        user.save(using=self._db)

        return user


class User(AbstractBaseUser, PermissionsMixin):
    """User in the system"""
    email = models.EmailField(max_length=255, unique=True)
    name = models.CharField(max_length=255)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    objects = UserManager()

    USERNAME_FIELD = 'email'
