module main

struct Item {
	id    int    [primary; sql: serial]
	fullname string
	tel string
}

pub fn (app &App) create_item(rec Item) {
	sql app.db {
		insert rec into Item
	}
}

pub fn (app &App) find_all(limit int, offset int) []Item {
	return sql app.db {
		select from Item
	}
}

pub fn (app &App) find_by_id(id int) Item {
	return sql app.db {
		select from Item where id == id limit 1
	}
}

pub fn (app &App) update_by_id(rid int, raw1 string, raw2 string) {
	sql app.db {
		 update Item set fullname = raw1, tel = raw2  where id == rid
	}
}

pub fn (app &App) delete_by_id(rid int) {
	sql app.db {
		 delete from Item where id == rid
	}
}