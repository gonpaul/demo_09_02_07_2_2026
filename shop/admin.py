from django.contrib import admin

# Register your models here.
from .models import Tovar, Zakaz, TovarVZakaze, CustomUser

admin.site.register(Tovar)
admin.site.register(Zakaz)
admin.site.register(TovarVZakaze)
admin.site.register(CustomUser)