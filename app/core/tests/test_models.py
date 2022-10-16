"""
Tests for models
"""

from django.test import TestCase
from django.contrib.auth import get_user_model  # Helper function to get the default user model


class ModelTests(TestCase):
    """Test Models"""

    def test_create_user_with_email_successful(self):
        """Test creating a user with email is successful"""
        email = 'test@example.com'
        password = 'testpass123'
        user = get_user_model().objects.create_user(
            email=email,  # username not passed to default user model to will give the error
            password=password,
        )

        self.assertEqual(user.email, email)
        self.assertTrue(user.check_password(password))
