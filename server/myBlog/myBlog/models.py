# models.py
from django.db import models
from django.contrib.auth.models import User

class Blog(models.Model):
    id = models.AutoField(primary_key=True)  # This line is optional, as Django does this by default
    CATEGORY_CHOICES = [
        ('Technology', 'Technology'),
        ('Busniess', 'Busniess'),
        ('Entertainment', 'Entertainment'),
        ('Health', 'Health'),
    ]

    title = models.CharField(max_length=100)
    content = models.TextField()
    category = models.CharField(max_length=20, choices=CATEGORY_CHOICES)
    image = models.ImageField(upload_to='blog_images/', null=True, blank=True)
    author = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title
