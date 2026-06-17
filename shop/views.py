from django.contrib.auth import login
from django.contrib.auth.views import login_required
from django.shortcuts import redirect, render
from django.views.generic import ListView

from shop.models import CustomUser, KategoriaTovara, Tovar

# Create your views here.
# @login_required
# def index(request):
#     return render(request, template_name='index.html')

def guest_login(request):
    guest = CustomUser.objects.get(username='guest')
    login(request, guest)
    return redirect('index')
    
# @login_required
class Index(ListView):
    model = Tovar
    template_name = 'index.html'
    context_object_name = 'tovari'

    def get_queryset(self):
        qs = Tovar.objects.all()
        query = self.request.GET.get('q', '')

        # поиск
        if query:
            qs = qs.filter(name__iregex=query)
        
        # фильтр по категориям
        category = self.request.GET.get('category', '')
        if category:
            qs = qs.filter(kategoria__name=category)
        
        # сортировка
        sort = self.request.GET.get('sort', '')
        if sort == 'price_asc':
            qs = qs.order_by('cena')
        if sort == 'price_desc':
            qs = qs.order_by('-cena')

        return qs
    
    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(object_list=object_list, **kwargs)
        context['categories'] = KategoriaTovara.objects.all()
        context['current_category'] = self.request.GET.get('category', '')
        context['current_sort'] = self. request.GET.get('sort', '')
        context['current_q'] = self.request.GET.get('q', '')
        return context