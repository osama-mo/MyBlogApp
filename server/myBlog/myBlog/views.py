from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework import status

from myBlog.models import Blog
from myBlog.serializers import BlogSerializer


# Auth API

@api_view(['POST'])
@permission_classes([AllowAny])
def register(request):
    firstname = request.data.get('name')
    username = request.data.get('username')
    password = request.data.get('password')
    if User.objects.filter(username=username).exists():
        return Response({'error': 'Username already exists'}, status=status.HTTP_400_BAD_REQUEST)
    user = User.objects.create_user(username=username, password=password, first_name =firstname)
    token, _ = Token.objects.get_or_create(user=user)
    return Response({
            'token': token.key,
            'id': user.id,
            'username': user.username,
            'first_name': user.first_name
        }, status=status.HTTP_201_CREATED)

@api_view(['POST'])
@permission_classes([AllowAny])
def login(request):
    username = request.data.get('username')
    password = request.data.get('password')
    user = authenticate(username=username, password=password)
    if user is not None:
        token, _ = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'id': user.id,
            'username': user.username,
            'first_name': user.first_name
        }, status=status.HTTP_200_OK)
    else:
        if User.objects.filter(username=username).exists():
            return Response({'error': 'Invalid password'}, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response({'error': 'User does not exist'}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@permission_classes([AllowAny])
def getUserByAccessToken(request):
    try: 
        print(request.data.get('token'))
        user = Token.objects.get(key= request.data.get('token') ).user
        pass
    except:
        return Response({'error': 'User does not exist'}, status=status.HTTP_400_BAD_REQUEST)
        
    
    if user is not None:
        token, _ = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'id': user.id,
            'username': user.username,
            'first_name': user.first_name
        }, status=status.HTTP_200_OK)
    else:
        return Response({'error': 'User does not exist'}, status=status.HTTP_400_BAD_REQUEST)



@api_view(['GET'])
@permission_classes([IsAuthenticated])
def protected_view(request):
    return Response({'message': 'This is a protected view'}, status=status.HTTP_200_OK)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def list_users(request):
    users = User.objects.all()
    user_data = [{'username': user.username, 'email': user.email} for user in users]
    return Response(user_data, status=status.HTTP_200_OK)



# Blogs API

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_blog(request):
    serializer = BlogSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save(author=request.user)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def list_blogs(request):
    blogs = Blog.objects.all()
    serializer = BlogSerializer(blogs, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)