from django.shortcuts import render, redirect
from django.db.models import Q
from .models import Users, Products, Suppliers


def login_view(request):
    """Страница авторизации (главная)."""
    if request.method == 'POST':
        login = request.POST.get('login')
        password = request.POST.get('password')

        try:
            user = Users.objects.select_related('role').get(
                login=login,
                password=password
            )
            request.session['user_id'] = user.id
            request.session['user_fio'] = user.full_name
            request.session['user_role'] = user.role.name
            return redirect('products')
        except Users.DoesNotExist:
            return render(request, 'login.html', {
                'error': 'Неверный логин или пароль'
            })

    return render(request, 'login.html')


def logout_view(request):
    """Выход из системы."""
    request.session.flush()
    return redirect('login')


def products_view(request):
    """Список товаров с фильтрацией/сортировкой/поиском по ролям."""
    user_role = request.session.get('user_role')
    can_filter = user_role in ['Менеджер', 'Администратор']
    can_edit = user_role == 'Администратор'

    products = Products.objects.select_related(
        'category', 'producer', 'supplier'
    ).all()

    search_query = ''
    selected_supplier = ''
    sort_by = ''

    if can_filter:
        search_query = request.GET.get('search', '').strip()
        if search_query:
            products = products.filter(
                Q(name__icontains=search_query) |
                Q(description__icontains=search_query) |
                Q(sku__icontains=search_query) |
                Q(category__name__icontains=search_query) |
                Q(producer__name__icontains=search_query) |
                Q(supplier__name__icontains=search_query)
            )

        selected_supplier = request.GET.get('supplier', '')
        if selected_supplier:
            products = products.filter(supplier_id=selected_supplier)

        sort_by = request.GET.get('sort', '')
        if sort_by == 'stock_qty':
            products = products.order_by('stock_qty')
        elif sort_by == '-stock_qty':
            products = products.order_by('-stock_qty')

    suppliers = Suppliers.objects.all() if can_filter else []

    context = {
        'products': products,
        'user_fio': request.session.get('user_fio'),
        'user_role': user_role,
        'can_filter': can_filter,
        'can_edit': can_edit,
        'suppliers': suppliers,
        'search_query': search_query,
        'selected_supplier': selected_supplier,
        'sort_by': sort_by,
    }

    if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        return render(request, 'products_table.html', context)

    return render(request, 'products.html', context)