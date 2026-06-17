from django.db import models
from django.contrib.auth.models import AbstractUser

# class RoleChoices(models.TextChoices):
#     USER = 'user', 'Авторизированный клиент'     # ('значение в БД', 'метка для отображения')
#     MANAGER = 'manager', 'Менеджер'
#     ADMIN = 'admin', 'Администратор'

# Create your models here.
class CustomUser(AbstractUser):
    role = models.CharField(
        max_length = 32, 
        # choices = RoleChoices,
        # default = RoleChoices.USER
        default = 'Авторизированный клиент'
    )
    fio = models.CharField(max_length=100)
    # USERNAME_FIELD = 'email'
    # поле password НЕ объявляем – оно есть в AbstractUser
    # при необходимости username можно переопределить, но осторожно

    def save(self, *args, **kwargs):
        if self.role:
            # if self.role == RoleChoices.ADMIN:
            if self.role == 'Администратор':
                self.is_staff = True
                self.is_superuser = True
            elif self.role == 'Менеджер':
                self.is_staff = True 
                self.is_superuser = False
            else:
                self.is_staff = False
                self.is_superuser = False
        super().save(*args, **kwargs)

    def __str__(self):
        return f'{self.fio, self.role}'

# proizvoditel
# postavschik
# kategoriatovara
# tovar

class Proizvoditel(models.Model):
    name = models.CharField(unique=True)
    def __str__(self):
        return self.name

class Postavschik(models.Model):
    name = models.CharField(unique=True)
    def __str__(self):
        return self.name

class KategoriaTovara(models.Model):
    name = models.CharField(unique=True)
    def __str__(self):
        return self.name

class Tovar(models.Model):
    artikul = models.CharField(max_length=20, unique=True)
    name = models.CharField(max_length=40)
    cena = models.IntegerField()
    postavschik = models.ForeignKey(Postavschik, on_delete=models.CASCADE)
    proizvoditel = models.ForeignKey(Proizvoditel, on_delete=models.CASCADE)
    kategoria = models.ForeignKey(KategoriaTovara, on_delete=models.PROTECT)
    skidka = models.IntegerField()
    na_sklade = models.IntegerField()
    opisanie = models.CharField(max_length=400)
    foto = models.FilePathField(path='/home/user/Documents/hexlet/exam/shoes_var/assets', default='picture.png', null=True)

    @property
    def discount_price(self):
        return int(self.cena * (1 - self.skidka / 100))

    def __str__(self):
        return f'${self.name}, ${self.postavschik}, ${self.cena} руб'

# PunktVidachi
# Zakaz
# TovarVZakaze

class PunktVidachi(models.Model):
    name = models.CharField(unique=True)
    def __str__(self):
        return self.name

class StatusZakaza(models.Model):
    name = models.CharField(unique=True)
    def __str__(self):
        return self.name

class Zakaz(models.Model):
    id = models.PositiveIntegerField(primary_key=True)
    data_zakaza = models.DateField()
    data_dostavki = models.DateField()
    punkt_vidachi = models.ForeignKey(PunktVidachi, on_delete=models.CASCADE)
    fio_klienta = models.CharField()
    kod = models.IntegerField(unique=True)
    status = models.ForeignKey(StatusZakaza, on_delete=models.PROTECT)

    def __str__(self):
        return f'${self.id}, ${self.fio_klienta}'

class TovarVZakaze(models.Model):
    zakaz = models.ForeignKey(Zakaz, on_delete=models.CASCADE)
    tovar = models.ForeignKey(Tovar, on_delete=models.CASCADE)
    kolichestvo = models.IntegerField()

    def __str__(self):
        return f'Заказ ${self.zakaz.id}, ${self.tovar.name} ${self.kolichestvo} шт.'
    


