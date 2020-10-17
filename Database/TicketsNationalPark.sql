-- sqlplus system/admin
-- conn admin_tickets/admin1234;
-- @"C:\Users\luisj\Google Drive\Portafolio de proyectos\Tickets National Park\DataBase\TicketsNationalPark.sql"
-- PROJECT: TICKET NATIONAL PARK.
-- LUIS J. BRAVO ZÚÑIGA.
-- SCRIPT DATA BASE (ORACLE).

	host cls;
	
	set linesize 200
	set pagesize 300

	PROMPT *** PROJECT: TICKET NATIONAL PARK.
	PROMPT *** LUIS J. BRAVO ZUNIGA.
	PROMPT *** SCRIPT DATA BASE (ORACLE).
	
	PROMPT [SYSTEM: START SCRIPT]
	
	conn system/admin
	
	PROMPT [ADMIN_TICKETS: DROPING USER]
	drop user admin_tickets cascade;
	
	PROMPT [SYSTEM: CREATE USER ADMIN]
	create user admin_tickets identified by admin1234;
	grant dba to admin_tickets;
	conn admin_tickets/admin1234;

	PROMPT [ADMIN_TICKETS: DROPING TABLES]
	
	PROMPT [ADMIN_TICKETS: DROPING USER TABLE]
	drop table Users;
	
	PROMPT [ADMIN_TICKETS: DROPING USER PURCHASE]
	drop table Purchase;
	
	PROMPT [ADMIN_TICKETS: DROPING USER RESERVATION]
	drop table Reservation;
	
	PROMPT [ADMIN_TICKETS: DROPING SEQUENCES]
	
	PROMPT [ADMIN_TICKETS: DROPING SEQUENCES FOR PURCHASE]
	drop sequence PK_seq_purchase;
	
	PROMPT [ADMIN_TICKETS: CREATING TABLES]
		
	PROMPT [ADMIN_TICKETS: CREATING TABLE USER]
	create table Users(
	username			varchar2(25)		not null,
	password			varchar2(15)		not null,
	state_data			varchar2(1)			not null
	);
	
	PROMPT [ADMIN_TICKETS: CREATING TABLE PURCHASE]
	create table Purchase(
	id					number(10)			not null,
	id_purchaser		varchar2(9)			not null,
	first_name			varchar2(20)		not null,
	last_name			varchar2(20)		not null,
	email				varchar2(30)		not null,
	telephone			varchar2(8)			null,
	quantity_tickets	number(1)			not null,
	reservation_date	date				not null,
	total				float				not null,
	state_data			varchar2(1)			not null
	);
	
	PROMPT [ADMIN_TICKETS: CREATING TABLE RESERVATION]
	create table Reservation(
	id				date					not null,
	available		number(4)				not null,
	sold			number(4)				not null,
	state_data		varchar2(1)				not null
	);
	
	PROMPT [ADMIN_TICKETS: CREATING SEQUENCES]
	
	PROMPT [ADMIN_TICKETS: CREATING SEQUENCES FOR PURCHASE]
	create sequence PK_seq_purchase start with 1 increment by 1 cache 2;
	
	PROMPT [ADMIN_TICKETS: CREATING RESTRICTIONS]
	
	-- NOTE: PRIMARY KEY
	PROMPT [ADMIN_TICKETS: CREATING PRIMARY KEY OF TABLE USERS]
	alter table Users add constraint PK_user primary key (username);
	
	PROMPT [ADMIN_TICKETS: CREATING PRIMARY KEY OF TABLE PURCHASE]
	alter table Purchase add constraint PK_purchase primary key (id);
	
	PROMPT [ADMIN_TICKETS: CREATING PRIMARY KEY OF TABLE RESERVATION]
	alter table Reservation add constraint PK_reservation primary key (id);
	
	-- NOTE: FOREIGN KEY
	PROMPT [ADMIN_TICKETS: CREATING FOREIGN KEY OF TABLE RESERVATION]
	alter table Purchase add constraint FK_purcharse_reservation foreign key (reservation_date) references Reservation;
	
	-- NOTE: CHECK CONSTRAINT FOR STATE OF DATA
	PROMPT [ADMIN_TICKETS: CREATING CHECK CONSTRAINT FOR DATA STATE. THIS ATRIBUTTE ONLY CAN TAKE TWO VALUES: 'A' OR 'I']
	alter table Users add constraint cdt_state_data_users check (state_data in ('A', 'I'));
	alter table Purchase add constraint cdt_state_data_purchase check (state_data in ('A', 'I'));
	alter table Reservation add constraint cdt_state_data_reservation check (state_data in ('A', 'I'));

	PROMPT [ADMIN_TICKETS: CREATING PROCEDURE]

	-- NOTE: PROCEDURE FOR INSERT, UPDATE AND DELETE USERS
	PROMPT [ADMIN_TICKETS: CREATING PROCEDURE FOR INSERT USERS]
	create or replace procedure p_insert_user(arg_username in users.username%type, arg_password in users.password%type) is 
	begin
	    insert into users(username, password, state_data) values (upper(arg_username), arg_password, 'A');
		commit;
	end p_insert_user;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: CREATING PROCEDURE FOR UPDATE USERS]
	create or replace procedure p_update_user(arg_username in users.username%type, arg_password in users.password%type) is
	begin
		update Users set password = arg_password where username = upper(arg_username) and state_data = 'A';
		commit;
	end p_update_user;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: CREATING PROCEDURE FOR DELETE USERS]
	create or replace procedure p_delete_user(arg_username in users.username%type) is
	begin
		update Users set state_data = 'I' where username = upper(arg_username) and state_data = 'A';
		commit;
	end p_delete_user;
	/
	show errors
	
	-- NOTE: PROCEDURE FOR INSERT AND DELETE PURCHASE
	PROMPT [ADMIN_TICKETS: CREATING PROCEDURE FOR INSERT PURCHASE]
	create or replace procedure p_insert_purchase(arg_id_purchaser in purchase.id_purchaser%type, arg_first_name in purchase.first_name%type, arg_last_name in purchase.last_name%type, arg_email in purchase.email%type, arg_telephone in purchase.telephone%type, arg_quantity_tickets in purchase.quantity_tickets%type, arg_reservation_date in purchase.reservation_date%type, arg_total in purchase.total%type) is
	begin
		insert into purchase(id, id_purchaser, first_name, last_name, email, telephone, quantity_tickets, reservation_date, total, state_data) values (PK_seq_purchase.nextval, arg_id_purchaser, upper(arg_first_name), upper(arg_last_name), arg_email, nvl(arg_telephone, 'NULL'), arg_quantity_tickets, to_date(arg_reservation_date, 'dd-mm-YYYY'), arg_total, 'A');
		commit;
	end p_insert_purchase;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: CREATING PROCEDURE FOR DELETE PURCHASE]
	create or replace procedure p_delete_purchase(arg_id in purchase.id%type) is
	begin
		update Purchase set state_data = 'I' where id = arg_id and state_data = 'A';
		commit;
	end p_delete_purchase;
	/
	show errors
	
	-- NOTE: PROCEDURE FOR INSERT, UPDATE AND DELETE RESERVATION
	PROMPT [ADMIN_TICKETS: CREATING PROCEDURE FOR INSERT RESERVATION]
	create or replace procedure p_insert_reservation(arg_id in Reservation.id%type, arg_available in Reservation.available%type) is
	begin
		insert into Reservation(id, available, sold, state_data) values (to_date(arg_id, 'dd-mm-yyyy'), arg_available, 0, 'A');
		commit;
	end p_insert_reservation;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: CREATING PROCEDURE FOR UPDATE RESERVATION]
	create or replace procedure p_update_reservation(arg_id in Reservation.id%type, arg_quantity_tickets in Reservation.sold%type) is
	begin
		update Reservation set sold = (sold + arg_quantity_tickets) 
		where to_date(id, 'dd-mm-yyyy') = to_date(arg_id, 'dd-mm-yyyy') and state_data = 'A';
		commit;
	end p_update_reservation;
	/
	show errors
		
	PROMPT [ADMIN_TICKETS: CREATING PROCEDURE FOR DELETE RESERVATION]
	create or replace procedure p_delete_reservation(arg_id in Reservation.id%type) is
	begin
		update Reservation set state_data = 'I' 
		where to_date(id, 'dd-mm-yyyy') = to_date(arg_id, 'dd-mm-yyyy') and state_data = 'A'; 
		commit;
	end p_delete_reservation;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: GET CURSOR]
	
	create or replace package TYPES
	as
	type ref_cursor is ref cursor;
	end;
	/
	show error
	
	PROMPT [ADMIN_TICKETS: CREATING FUNCTION]
	
	-- NOTE: FUNCTION FOR CONSULT, LIST USERS AND CHECK LOGIN.
	PROMPT [ADMIN_TICKETS: CREATING FUNCTION FOR CONSULT USERS]
	create or replace function f_consult_user(arg_username in Users.username%type) return TYPES.ref_cursor 
	as
	c_users_data TYPES.ref_cursor;
	begin
		open c_users_data for
		select username, password
		from Users
		where username = upper(arg_username) and state_data = 'A';
		return c_users_data;
	end f_consult_user;
	/
	show errors

	PROMPT [ADMIN_TICKETS: CREATING FUNCTION FOR CHECK LOGIN]
	create or replace function f_check_login(arg_username in Users.username%type, arg_password in Users.password%type) return number is
	var_result number(1);
	begin
		select count(username)
		into var_result
		from Users 
		where username = upper(arg_username) and password = arg_password and state_data = 'A';
		return var_result;
	end f_check_login;
	/
	show errors
	
	-- NOTE: FUNCTION FOR CONSULT, LIST purchase, LIST purchase BASED ON RESERVATION DATE AND GET ID OF THE LAST PURCHASE.
	PROMPT [ADMIN_TICKETS: CREATING FUNCTION FOR CONSULT PURCHASE]
	create or replace function f_consult_purchase(arg_id in purchase.id%type) return TYPES.ref_cursor 
	as
	c_purchase_data TYPES.ref_cursor;
	begin
		open c_purchase_data for
		select id, id_purchaser, first_name, last_name, email, telephone, quantity_tickets, to_char(reservation_date, 'dd-mm-yyyy') reservation_date, total, state_data
		from purchase
		where id = arg_id;
		return c_purchase_data;
	end f_consult_purchase;
	/
	show errors

	PROMPT [ADMIN_TICKETS: CREATING FUNCTION FOR LIST purchase]
	create or replace function f_list_purchase return TYPES.ref_cursor 
	as
	c_purchase_data TYPES.ref_cursor;
	begin
		open c_purchase_data for
		select id, id_purchaser, first_name, last_name, email, telephone, quantity_tickets, to_char(reservation_date, 'dd-mm-yyyy') reservation_date, total, state_data
		from purchase;
		return c_purchase_data;
	end f_list_purchase;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: CREATING FUNCTION FOR LIST purchase BASED ON DATE]
	create or replace function f_list_purchase_date(arg_trans_date in purchase.reservation_date%type) return TYPES.ref_cursor 
	as
	c_purchase_data TYPES.ref_cursor;
	begin
		open c_purchase_data for
		select id, id_purchaser, first_name, last_name, email, telephone, quantity_tickets, to_char(reservation_date, 'dd-mm-yyyy') reservation_date, total, state_data
		from purchase
		where to_date(reservation_date, 'dd-mm-yyyy') <= to_date(arg_trans_date, 'dd-mm-yyyy') and state_data = 'A';
		return c_purchase_data;
	end f_list_purchase_date;
	/
	show errors
	
    PROMPT [ADMIN_TICKETS: CREATING FUNCTION FOR GET ID OF THE LAST PURCHASE]
	create or replace function f_get_id_purchase return number is
	var_id number;
	begin
		select id
		into var_id
		from Purchase 
		where rowid in (select max(rowid) from Purchase);
		return var_id;	
	end f_get_id_purchase;
	/
	show errors
	
	-- NOTE: FUNCTION FOR CONSULT, LIST RESERVATION, LIST RESERVATION BASED ON DATE.
	PROMPT [ADMIN_TICKETS: CREATING FUNCTION FOR CONSULT RESERVATION]
	create or replace function f_consult_reservation(arg_id in Reservation.id%type) return TYPES.ref_cursor 
	as
	c_reservation_data TYPES.ref_cursor;
	begin
		open c_reservation_data for
		select to_char(id, 'dd-mm-yyyy') id, available, sold, state_data
		from Reservation
		where to_date(id, 'dd-mm-yyyy') = to_date(arg_id, 'dd-mm-yyyy');
		return c_reservation_data;
	end f_consult_reservation;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: CREATING FUNCTION FOR LIST RESERVATION BASED ON A DATE]
	create or replace function f_consult_reservation_date(arg_date in Reservation.id%type)  return TYPES.ref_cursor 
	as
	c_reservation_data TYPES.ref_cursor;
	begin
		open c_reservation_data for
		select to_char(id, 'dd-mm-yyyy') id, available, sold, state_data
		from Reservation
		where to_date(id, 'dd-mm-yyyy') <= to_date(arg_date, 'dd-mm-yyyy');
		return c_reservation_data;
	end f_consult_reservation_date;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: CREATING FUNCTION FOR LIST RESERVATION]
	create or replace function f_list_reservation return TYPES.ref_cursor 
	as
	c_reservation_data TYPES.ref_cursor;
	begin
		open c_reservation_data for
		select to_char(id, 'dd-mm-yyyy') id, available, sold, state_data
		from Reservation
		where state_data = 'A';
		return c_reservation_data;
	end f_list_reservation;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: CREATING OTHERS FUNCTIONS TO VALIDATE OPERATIONS]
	
	PROMPT [ADMIN_TICKETS: CREATING FUNCTION FOR GET QUANTITY OF TICKETS AVAILABLE]
	create or replace function f_enough_for_sold(arg_date in Reservation.id%type) return number is
	var_result number;
	begin
		select (available - sold) 
		into var_result
		from Reservation
		where to_date(id, 'dd-mm-yyyy') = to_date(arg_date, 'dd-mm-yyyy') and state_data = 'A';
		return var_result;
	end f_enough_for_sold;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: CREATING FUNCTION FOR CHECK TICKETS]
	create or replace function f_can_purchase(arg_date in Reservation.id%type, arg_quantity_tickets in Purchase.quantity_tickets%type) return number is
	begin
		if f_enough_for_sold(arg_date) >= arg_quantity_tickets then 
			return 1;
		end if;
		return 0;
	end f_can_purchase;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: CREATING TRIGGERS]
	
	PROMPT [ADMIN_TICKETS: CREATING TRIGGERS AFTER INSERT PURCHASE]
	create or replace trigger t_af_insert_purchase after insert on Purchase referencing old as item_old new as item_new 
	for each row
	begin
		update Reservation set sold = (sold + :item_new.quantity_tickets) 
		where to_date(id, 'dd-mm-yyyy') = to_date(:item_new.reservation_date, 'dd-mm-yyyy') and state_data = 'A';
	end t_af_insert_purchase;
	/
	show errors
	
	PROMPT [ADMIN_TICKETS: INSERTING DATA]
	
	PROMPT [ADMIN_TICKETS: INSERTING USERS]
	execute p_insert_user('admin@yosemite.com', 'Admin1234$');
	execute p_insert_user('lbravo@yosemite.com', 'Admin1234$');
	execute p_insert_user('dmora@yosemite.com', 'Admin1234$');
	execute p_insert_user('lcressant@yosemite.com', 'Admin1234$');
	
	PROMPT [ADMIN_TICKETS: INSERTING RESERVATION]
	execute p_insert_reservation(sysdate+1, 100);
	execute p_insert_reservation(sysdate+2, 100);
	execute p_insert_reservation(sysdate+3, 100);
	execute p_insert_reservation(sysdate+4, 100);
	execute p_insert_reservation(sysdate+5, 100);
	execute p_insert_reservation(sysdate+6, 100);
	
	PROMPT [ADMIN_TICKETS: INSERTING PURCHASE]
	execute p_insert_purchase('402380339', 'Samuel', 'Hummels', 'shummels@gmail.com', null, 4, to_date(sysdate+1, 'dd-mm-yyyy'), 15);
	execute p_insert_purchase('201631332', 'Alexei', 'Cressant', 'acressant@gmail.com', '20302212', 3,  to_date(sysdate+2, 'dd-mm-yyyy'), 11.25);
	execute p_insert_purchase('456120097', 'Yul', 'Kwon','ykwon@gmail.com', null, 4,  to_date(sysdate+1, 'dd-mm-yyyy'), 15);
	execute p_insert_purchase('258218892', 'Ethan', 'Zohn', 'ezohn@gmail.com', '88123200', 2,  to_date(sysdate+3, 'dd-mm-yyyy'), 7.5);
	execute p_insert_purchase('402380339', 'Kim', 'Spradlin-Wolfe', 'spradlin-Wolfe@gmail.com', '22003012', 5,  to_date(sysdate+1, 'dd-mm-yyyy'), 18.75);
	execute p_insert_purchase('334453126', 'Cirie', 'Fields', 'cfields@gmail.com', '21009023', 6,  to_date(sysdate+4, 'dd-mm-yyyy'), 22.5);
	execute p_insert_purchase('342120649', 'Parvati', 'Shallow', 'pshallow@gmail.com', null, 3,  to_date(sysdate+2, 'dd-mm-yyyy'), 11.25);
	execute p_insert_purchase('227653903', 'Sophie', 'Clarke', 'sclarkegmail.com', '22331010', 9,  to_date(sysdate+5, 'dd-mm-yyyy'), 33.75);
	execute p_insert_purchase('112550672', 'Denise', 'Stapley', 'dstapley@gmail.com', null, 3,  to_date(sysdate+4, 'dd-mm-yyyy'), 11.25);
	execute p_insert_purchase('613310540', 'Sundra', 'Oakley', 'soakley@gmail.com', null, 6,  to_date(sysdate+4, 'dd-mm-yyyy'), 22.5);
	
	-- NOTE: FINAL COMMIT;
	commit;
	
	PROMPT [SYSTEM: END OF SCRIPT]