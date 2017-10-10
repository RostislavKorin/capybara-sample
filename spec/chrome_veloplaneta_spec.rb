require 'spec_helper'

describe 'Unregistered customer', :type => :feature do
  it 'makes order', js: true do
    visit('/test-product.html')
    expect(page).to have_content 'Это демонстрационный магазин'
    click_button('Купить')
    expect(page).to have_content('Вы добавили')
    click_on('Перейти в корзину')
    expect(page).to have_content('Корзина')
    expect(page).to have_content('Test Product')
    click_button('Оформить заказ')
    fill_in('Адрес электронной почты (email)', :with => 'test@mail.com')
    fill_in('Имя', :with => 'test_first_name')
    fill_in('Фамилия', :with => 'test_second_name')
    select('Авангард', :from => 'Город')
    fill_in('Мобильный телефон', :with => '000000000')
    click_on('Следующий')
    select('Самовывоз', :from => 'Тип доставки')
    select('НоваПошта', :from => 'Служба доставки')
    select('Отделение № 1: ул. Ангарская, 13/1', :from => 'Отделение')
    click_on('Следующий')
    expect(page).to have_content('Метод оплаты:')
    find('label', :text => 'Наложенный платеж').click
    click_on('Оформить заказ')
    expect(page).to have_content('Спасибо за покупку')
  end
end

 describe 'Registered customer', :type => :feature do
  it 'makes order', js: true do
    visit('/customer/account/login/')
    fill_in('Адрес электронной почты (email)', :with => 'test@mail.com')
    fill_in('Пароль', :with => '1qaz_2wsx')
    click_button('Войти')
    expect(page).to have_content('Моя панель управления')
    expect(page).to have_content('Test Customer')
    visit('/test-product.html')
    expect(page).to have_content('Test Customer')
    expect(page).to have_content('Test Product')
    click_button('Купить')
    expect(page).to have_content('Вы добавили')
    click_on('Перейти в корзину')
    expect(page).to have_content('Корзина')
    expect(page).to have_content('Test Product')
    click_button('Оформить заказ')
    element = find_button("Следующий")
    sleep 2
    element.click()
    select('Самовывоз', :from => 'Тип доставки')
    expect(page).to have_content('Тип доставки')
    select('НоваПошта', :from => 'Служба доставки')
    select('Отделение № 1: ул. Ангарская, 13/1', :from => 'Отделение')
    element = find_button("Следующий")
    sleep 2
    element.click()
    expect(page).to have_content('Метод оплаты:')
    find('label', :text => 'Наложенный платеж').click
    click_on('Оформить заказ')
    expect(page).to have_content('Спасибо за покупку')
  end

  it 'makes order with new address', js: true do
     visit('/customer/account/login/')
     fill_in('Адрес электронной почты (email)', :with => 'test@mail.com')
     fill_in('Пароль', :with => '1qaz_2wsx')
     click_button('Войти')
     expect(page).to have_content('Моя панель управления')
     expect(page).to have_content('Test Customer')
     visit('/test-product.html')
     expect(page).to have_content('Test Customer')
     expect(page).to have_content('Test Product')
     click_button('Купить')
     expect(page).to have_content('Вы добавили')
     click_on('Перейти в корзину')
     expect(page).to have_content('Корзина')
     expect(page).to have_content('Test Product')
     click_button('Оформить заказ')
     click_button('Новый адрес')
     element = find_button("Сохранить адрес")
     sleep 2
     element.click()
     next_button = find_button("Следующий")
     sleep 2
     next_button.click()
     select('Самовывоз', :from => 'Тип доставки')
     expect(page).to have_content('Тип доставки')
     select('НоваПошта', :from => 'Служба доставки')
     select('Отделение № 1: ул. Ангарская, 13/1', :from => 'Отделение')
     next_button = find_button("Следующий")
     sleep 2
     next_button.click()
     page.first('a', :text => 'Редактировать').click
     expect(page).to have_content('Личная информация')
     sleep 2
     next_button.click()
     page.first('a', :text => 'Редактировать').click
     sleep 2
     next_button.click()
     expect(page).to have_content('Тип доставки')
     sleep 2
     next_button.click()
     expect(page).to have_content('Метод оплаты')
     find('label', :text => 'Наложенный платеж').click
     click_on('Оформить заказ')
     expect(page).to have_content('Спасибо за покупку')
  end
end
