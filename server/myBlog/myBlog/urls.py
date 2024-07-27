from django.urls import path
from django.conf.urls.static import static

from myBlog import settings
from .views import create_blog, list_blogs, register, login, protected_view, list_users, getUserByAccessToken
from django.contrib import admin

urlpatterns = [
    path('register/', register, name='register'),
    path('login/', login, name='login'),
    path('protected/', protected_view, name='protected'),
    path('users/', list_users, name='list_users'),
    path('admin/', admin.site.urls),
    path('getUserByToken/', getUserByAccessToken, name='getUserByAccessToken'),
    path('create_blog/', create_blog, name='create_blog'),
    path('get_all_blogs/', list_blogs, name='list_blogs'),
]


if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)