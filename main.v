module main

import vweb
import os
import sqlite


struct App {
	vweb.Context
pub mut:
	db      sqlite.DB
	user_id string
}

fn main() {
	mut app := App{
		db: sqlite.connect('site.sqlite') or { panic(err) }
	}
	app.db.journal_mode(sqlite.JournalMode.memory)
	sql app.db {
		create table Item
	}
	app.serve_static('/favicon.ico', 'ui/favicon.ico')
	app.serve_static('/assets/logo.svg', 'ui/assets/logo.svg')
	app.serve_static('/assets/chota.min.css', 'ui/assets/chota.min.css')
	app.serve_static('/assets/doc-styles.css', 'ui/assets/doc-styles.css')
	os.chdir(os.dir(os.executable()))? // Automatically make available known static mime types found in given directory.
	app.handle_static('assets', true)
	vweb.run(app, 8081)
}
