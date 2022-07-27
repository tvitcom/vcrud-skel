module main

import vweb

['/index'; get]
pub fn (app &App) index() vweb.Result {
	limit := 100
	cnt := 0
	records := app.find_all(limit, cnt)
	return $vweb.html()
}

['/about'; get]
pub fn (app &App) about() vweb.Result {
	return $vweb.html()
}

['/new'; get]
pub fn (mut app App) new() vweb.Result {
	return $vweb.html()
}

['/new'; post]
pub fn (mut app App) new_posted() vweb.Result {
	fullname := app.form['fullname']
	tel := app.form['tel']
	if fullname == '' || tel == '' {
		return app.text('Empty tel/fullname')
	}
	rec := Item{
		fullname: fullname
		tel: tel
	}
	app.create_item(rec)
	return app.redirect('/')
}

['/edit/:rawid'; get]
fn (mut app App) edit(rawid string) vweb.Result {
	id := rawid.int()
	rec := app.find_by_id(id)
	return $vweb.html()
}

['/edit/:rawid'; post]
fn (mut app App) edit_posted(rawid string) vweb.Result {
	id := rawid.int()
	fullname := app.form['fullname']
	tel := app.form['tel']
	if fullname == '' || tel == '' {
		return app.text('Error item id in form')
	}
	app.update_by_id(id, fullname, tel)
	return app.redirect('/')
}

['/del/:rawid'; get]
fn (mut app App) del(rawid string) vweb.Result {
	id := rawid.int()
	rec := app.find_by_id(id)
	return $vweb.html()
}

['/del'; post]
fn (mut app App) del_posted() vweb.Result {
	rawid := app.form['rawid']
	if rawid == '' {
		return app.text('Error item id in form: $rawid')
	}
	id := rawid.int()
	app.delete_by_id(id)
	return app.redirect('/')
}