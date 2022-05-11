require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
	@db = SQLite3::Database.new 'barbershop.db'
		@db.execute 'CREATE TABLE IF NOT EXISTS "Users" (
	  "id"  INTEGER PRIMARY KEY AUTOINCREMENT,
	  "user_name" TEXT,
	  "phone" TEXT,
	  "date"  TEXT,
	  "master"  TEXT,
	  "colour"  TEXT
	)'
end



get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/about' do


	erb :about
end

get '/visit' do
	erb :visit
end

colors = { "#7bd148" => 'Зеленый', "#5484ed" => 'Темно-Голубой', "#a4bdfc" => 'Голубой', "#46d6db" => 'Бирюзовый',
"#7ae7bf" => 'Светло-Зеленый', "#51b749" => 'Темно-Зеленый', "#fbd75b" => 'Желтый', "#ffb878" => 'Оранжевый', "#ff887c" => 'Красный',
"#dc2127" => 'Темно-Красный', "#dbadff" => 'Пурпурный', "#e1e1e1" => 'Серый'}


post '/visit' do
	@user_name = params[:user_name]
	@phone = params[:phone]
	@date = params[:date]
	@master = params[:master]
	@ok_colour = colors[params[:color]]

hh = {:user_name => "Что-то пошло не так, введите имя", :phone => "Что-то пошло не так, введите телефон", :date => "Что-то пошло не так, выберите дату"}

hh.each do |key, value|

	if params[key] == ""
		@error = hh[key]
		return erb :visit

	end
end


#сообщение после ввода данных пользователя
@title = 'Спасибо, запись прошла успешно'
@message = "#{@user_name}, мы будем ждать Вас #{@date}. Ваш мастер #{@master}. Вы выбрали #{@ok_colour} цвет для окрашивания"

#запись данных, предоставленных пользователем в отдельный файл
		f = File.open("users_barbers.txt", "a")
		f.write "User: #{@user_name}, Phone: #{@phone}, Date: #{@date}, Master #{@master}, color: #{@ok_colour}\n\r"
		f.close
erb :message

end


#зона admin
get '/admin' do
	erb :admin
end

#пост-запрос в админ-зону с вводом логина и пароля
post '/admin' do
	@login = params[:login]
	@password = params[:pass]


#проверка логина и пароля
if @login == 'admin' && @password == 'admin'

#Выдача файла при верном пароле
send_file '/home/tesla/Projects/bak/22/RubySchool_Lesson_24/users_barbers.txt'
puts users_barbers.txt


else
	@title = 'Ошибка при вводе логина или пароля'
	@message  = 'Отказано в доступе'
end
end

get '/contacts' do
	erb :contacts
end

#пост-запрос на обратную связь с отправкой формы на мою почту

post '/contacts' do
	require 'pony'

Pony.mail(

  :to => 'teslagirl17@gmail.com',
  :subject => params[:name],
  :body => params[:text],

  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'teslagirl17',
    :password             => '20teslagirl69',
    :authentication       => :plain,
    :domain               => 'localhost.localdomain'
  })
redirect '/success'
end


