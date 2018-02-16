from django.conf.urls import url, include
from django.contrib import admin

from qa.views import popular, index, answer, test, question, ask, signup, user_login

urlpatterns = [
    url(r'^$', index, name='index'),
    url(r'^popular/.*$', popular, name='popular'),
    url(r'^ask/.*$', ask, name='ask'),
    url(r'^answer/.*$', answer, name='answer'),
    url(r'^new/.*$', test),
    url(r'^question/(?P<question_id>[\d]+)/$', question, name='question'),
    url(r'^signup/.*$', signup, name='signup'),
    url(r'^login/.*$', user_login, name='login'),
]
