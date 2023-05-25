
from django import forms
from django.forms import ModelForm, Textarea
from .models import Blog


class UpdateBlog(ModelForm):
    class Meta:
        model   = Blog 
        fields  = ('title', 'body', 'author', 'image')
        widgets = {
            'body': Textarea(attrs={'cols':120,'rows':15}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['image'].required = False

