# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Categories(models.Model):
    name = models.CharField(max_length=60)

    class Meta:
        managed = False
        db_table = 'categories'


class OrderItems(models.Model):
    order = models.ForeignKey('Orders', models.DO_NOTHING)
    product = models.ForeignKey('Products', models.DO_NOTHING)
    quantity = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'order_items'


class Orders(models.Model):
    order_date = models.DateField()
    delivery_date = models.DateField()
    pickup_point = models.ForeignKey('PickupPoints', models.DO_NOTHING)
    user = models.ForeignKey('Users', models.DO_NOTHING)
    code = models.CharField(max_length=20)
    status = models.CharField(max_length=40)

    class Meta:
        managed = False
        db_table = 'orders'


class PickupPoints(models.Model):
    address = models.TextField()

    class Meta:
        managed = False
        db_table = 'pickup_points'


class Producers(models.Model):
    name = models.TextField()

    class Meta:
        managed = False
        db_table = 'producers'


class Products(models.Model):
    sku = models.CharField(unique=True, max_length=20)
    name = models.CharField(max_length=100)
    price = models.FloatField()
    supplier = models.ForeignKey('Suppliers', models.DO_NOTHING)
    producer = models.ForeignKey(Producers, models.DO_NOTHING)
    category = models.ForeignKey(Categories, models.DO_NOTHING)
    discount = models.FloatField()
    stock_qty = models.IntegerField()
    description = models.TextField(blank=True, null=True)
    photo_path = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'products'

    @property
    def final_price(self):
        """Цена с учётом скидки."""
        if self.discount > 0:
            return self.price * (1 - self.discount / 100)
        return self.price


class Suppliers(models.Model):
    name = models.TextField(unique=True)

    class Meta:
        managed = False
        db_table = 'suppliers'


class UserRoles(models.Model):
    name = models.CharField(unique=True, max_length=40)

    class Meta:
        managed = False
        db_table = 'user_roles'


class Users(models.Model):
    full_name = models.TextField()
    login = models.TextField(unique=True)
    password = models.CharField(max_length=40)
    role = models.ForeignKey(UserRoles, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'users'
