"""
Sample tests
"""
from django.test import SimpleTestCase

from app import calc


class ClacTest(SimpleTestCase):
    """Test calc module"""

    def test_add_numbers(self):
        """Test adding numbers together"""
        res = calc.add(5, 2)

        self.assertEqual(res, 7)

    def test_subtract_numbers(self):
        """Test subtracting numbers"""
        res = calc.subtract(10, 15)

        self.assertEqual(res, 5)
