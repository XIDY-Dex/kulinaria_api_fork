PGDMP         (                |            kulinaria_db    15.4    15.4 f    x           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            y           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            z           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            {           1262    16536    kulinaria_db    DATABASE     �   CREATE DATABASE kulinaria_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE kulinaria_db;
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            |           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    6                        2615    16537    test_sh    SCHEMA        CREATE SCHEMA test_sh;
    DROP SCHEMA test_sh;
                postgres    false            �            1255    26943 4   data_user_upd(integer, integer, integer, text, date) 	   PROCEDURE       CREATE PROCEDURE public.data_user_upd(IN usr integer, IN ser integer, IN num integer, IN who text, IN dat date)
    LANGUAGE sql
    AS $$
update public.tb_user_data set passport_ser = ser, passport_num = num, who_issued = who, 
issue_date = dat where user_id = usr;
$$;
 o   DROP PROCEDURE public.data_user_upd(IN usr integer, IN ser integer, IN num integer, IN who text, IN dat date);
       public          postgres    false    6            �            1255    26944 K   data_user_upd(integer, integer, integer, text, timestamp without time zone) 	   PROCEDURE     &  CREATE PROCEDURE public.data_user_upd(IN usr integer, IN ser integer, IN num integer, IN who text, IN dat timestamp without time zone)
    LANGUAGE sql
    AS $$
update public.tb_user_data set passport_ser = ser, passport_num = num, who_issued = who, 
issue_date = dat where user_id = usr;
$$;
 �   DROP PROCEDURE public.data_user_upd(IN usr integer, IN ser integer, IN num integer, IN who text, IN dat timestamp without time zone);
       public          postgres    false    6            �            1255    26945 Q   data_user_upd(integer, integer, integer, text, timestamp without time zone, text) 	   PROCEDURE     �  CREATE PROCEDURE public.data_user_upd(IN usr integer, IN ser integer, IN num integer, IN who text, IN dat timestamp without time zone, IN email text)
    LANGUAGE plpgsql
    AS $$
begin
if exists (select * from public.tb_user_data where user_id = usr) then
	update public.tb_user_data set passport_ser = ser, passport_num = num, who_issued = who, 
	issue_date = dat, user_email = email where user_id = usr;
else
	insert into public.tb_user_data values (usr, ser, num, who, dat, email);
end if;
end;
$$;
 �   DROP PROCEDURE public.data_user_upd(IN usr integer, IN ser integer, IN num integer, IN who text, IN dat timestamp without time zone, IN email text);
       public          postgres    false    6            �            1255    26946    decrease(text) 	   PROCEDURE     �   CREATE PROCEDURE public.decrease(IN name_prod text)
    LANGUAGE sql
    AS $$
update public.products set prod_fats = prod_fats / 2;
$$;
 3   DROP PROCEDURE public.decrease(IN name_prod text);
       public          postgres    false    6            �            1255    26947    dish_by_exit(integer)    FUNCTION     �   CREATE FUNCTION public.dish_by_exit(ex integer) RETURNS TABLE(dname text, ex integer)
    LANGUAGE sql
    AS $$
select dish_name, base_exit from public.dishes
join public.dish_base on dish_base_id = base_id
where base_exit = ex
$$;
 /   DROP FUNCTION public.dish_by_exit(ex integer);
       public          postgres    false    6            �            1255    26948     dish_by_exit_base(text, integer)    FUNCTION     $  CREATE FUNCTION public.dish_by_exit_base(base text, ex integer) RETURNS TABLE(dname text, base text, ex integer)
    LANGUAGE sql
    AS $$
select dish_name, base_name, base_exit from public.dishes
join public.dish_base on dish_base_id = base_id
where base_exit = ex and base_name = base
$$;
 ?   DROP FUNCTION public.dish_by_exit_base(base text, ex integer);
       public          postgres    false    6            �            1255    16538    dish_exit(integer)    FUNCTION        CREATE FUNCTION public.dish_exit(e_mas integer) RETURNS TABLE(dn character varying, be integer)
    LANGUAGE sql
    AS $$
	select dish_name, base_exit
	from public.dishes
	inner join public.dish_base on dish_base_id = base_id
	where base_exit = e_mas $$;
 /   DROP FUNCTION public.dish_exit(e_mas integer);
       public          postgres    false    6            �            1255    16539 *   dish_exit_name(integer, character varying)    FUNCTION     W  CREATE FUNCTION public.dish_exit_name(e_mas integer, e_name character varying) RETURNS TABLE(dn character varying, bn character varying, be integer)
    LANGUAGE sql
    AS $$
	select dish_name, base_name, base_exit
	from public.dishes
	inner join public.dish_base on dish_base_id = base_id
	where base_exit = e_mas and base_name = e_name $$;
 N   DROP FUNCTION public.dish_exit_name(e_mas integer, e_name character varying);
       public          postgres    false    6            �            1255    16540 #   dish_type_insert(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.dish_type_insert(IN t_name character varying)
    LANGUAGE sql
    AS $$
	insert into public.dish_types(type_name)
	values (t_name)
$$;
 E   DROP PROCEDURE public.dish_type_insert(IN t_name character varying);
       public          postgres    false    6            �            1255    26949    increase(text) 	   PROCEDURE     �   CREATE PROCEDURE public.increase(IN name_prod text)
    LANGUAGE sql
    AS $$
update public.products set prod_fats = prod_fats * 2;
$$;
 3   DROP PROCEDURE public.increase(IN name_prod text);
       public          postgres    false    6            �            1255    26950    trigger_user_userdata()    FUNCTION     �   CREATE FUNCTION public.trigger_user_userdata() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
insert into public.tb_user_data 
values (new.user_id, 0, 0, '', now(), '');
return new;
end;
$$;
 .   DROP FUNCTION public.trigger_user_userdata();
       public          postgres    false    6            �            1255    26951 Z   update_datauser(integer, integer, integer, character varying, timestamp without time zone) 	   PROCEDURE     4  CREATE PROCEDURE public.update_datauser(IN usr integer, IN ser integer, IN num integer, IN who character varying, IN dat timestamp without time zone)
    LANGUAGE sql
    AS $$
update public.tb_user_data set passport_ser = ser, passport_num = num, who_issued = who,
issue_date = dat where user_id = usr;
$$;
 �   DROP PROCEDURE public.update_datauser(IN usr integer, IN ser integer, IN num integer, IN who character varying, IN dat timestamp without time zone);
       public          postgres    false    6            �            1255    26952 m   update_datauser(integer, integer, integer, character varying, timestamp without time zone, character varying) 	   PROCEDURE     d  CREATE PROCEDURE public.update_datauser(IN usr integer, IN ser integer, IN num integer, IN who character varying, IN dat timestamp without time zone, IN email character varying)
    LANGUAGE sql
    AS $$
update public.tb_user_data set passport_ser = ser, passport_num = num, who_issued = who,
issue_date = dat, user_email = email where user_id = usr;
$$;
 �   DROP PROCEDURE public.update_datauser(IN usr integer, IN ser integer, IN num integer, IN who character varying, IN dat timestamp without time zone, IN email character varying);
       public          postgres    false    6            �            1259    16541    tb_dish_base    TABLE        CREATE TABLE public.tb_dish_base (
    base_id integer NOT NULL,
    base_name character varying(20),
    base_exit integer
);
     DROP TABLE public.tb_dish_base;
       public         heap    postgres    false    6            �            1259    16544    dish_base_base_id_seq    SEQUENCE     �   CREATE SEQUENCE public.dish_base_base_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.dish_base_base_id_seq;
       public          postgres    false    6    215            }           0    0    dish_base_base_id_seq    SEQUENCE OWNED BY     R   ALTER SEQUENCE public.dish_base_base_id_seq OWNED BY public.tb_dish_base.base_id;
          public          postgres    false    216            �            1259    16545    tb_dish_type    TABLE     h   CREATE TABLE public.tb_dish_type (
    type_id integer NOT NULL,
    type_name character varying(10)
);
     DROP TABLE public.tb_dish_type;
       public         heap    postgres    false    6            �            1259    16548    dish_types_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.dish_types_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.dish_types_type_id_seq;
       public          postgres    false    6    217            ~           0    0    dish_types_type_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.dish_types_type_id_seq OWNED BY public.tb_dish_type.type_id;
          public          postgres    false    218            �            1259    16549    tb_dish    TABLE     �   CREATE TABLE public.tb_dish (
    dish_id integer NOT NULL,
    dish_name character varying(50),
    dish_type_id integer,
    dish_base_id integer,
    dish_image character varying(100)
);
    DROP TABLE public.tb_dish;
       public         heap    postgres    false    6            �            1259    16552    dishes_dish_id_seq    SEQUENCE     �   CREATE SEQUENCE public.dishes_dish_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.dishes_dish_id_seq;
       public          postgres    false    219    6                       0    0    dishes_dish_id_seq    SEQUENCE OWNED BY     J   ALTER SEQUENCE public.dishes_dish_id_seq OWNED BY public.tb_dish.dish_id;
          public          postgres    false    220            �            1259    16553 
   tb_product    TABLE     �   CREATE TABLE public.tb_product (
    prod_id integer NOT NULL,
    prod_name character varying(20),
    prod_protein integer,
    prod_fats integer,
    prod_carboh integer
);
    DROP TABLE public.tb_product;
       public         heap    postgres    false    6            �            1259    16556    products_prod_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_prod_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.products_prod_id_seq;
       public          postgres    false    221    6            �           0    0    products_prod_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.products_prod_id_seq OWNED BY public.tb_product.prod_id;
          public          postgres    false    222            �            1259    16557 	   tb_recipe    TABLE     o   CREATE TABLE public.tb_recipe (
    recipe_id integer NOT NULL,
    dishes_id integer,
    recipe_text text
);
    DROP TABLE public.tb_recipe;
       public         heap    postgres    false    6            �            1259    16562    recipe_recipe_id_seq    SEQUENCE     �   CREATE SEQUENCE public.recipe_recipe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.recipe_recipe_id_seq;
       public          postgres    false    6    223            �           0    0    recipe_recipe_id_seq    SEQUENCE OWNED BY     P   ALTER SEQUENCE public.recipe_recipe_id_seq OWNED BY public.tb_recipe.recipe_id;
          public          postgres    false    224            �            1259    27005    tb_order    TABLE     �   CREATE TABLE public.tb_order (
    order_id integer NOT NULL,
    order_user_id integer NOT NULL,
    order_address character varying(150) NOT NULL,
    order_date date DEFAULT now(),
    order_paytype_id integer NOT NULL
);
    DROP TABLE public.tb_order;
       public         heap    postgres    false    6            �            1259    27025    tb_order_cart    TABLE     �   CREATE TABLE public.tb_order_cart (
    cart_order_id integer NOT NULL,
    cart_prod_id integer NOT NULL,
    cart_prod_count integer NOT NULL
);
 !   DROP TABLE public.tb_order_cart;
       public         heap    postgres    false    6            �            1259    27004    tb_order_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_order_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.tb_order_order_id_seq;
       public          postgres    false    6    234            �           0    0    tb_order_order_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.tb_order_order_id_seq OWNED BY public.tb_order.order_id;
          public          postgres    false    233            �            1259    26998 
   tb_paytype    TABLE     f   CREATE TABLE public.tb_paytype (
    type_id integer NOT NULL,
    type_name character varying(50)
);
    DROP TABLE public.tb_paytype;
       public         heap    postgres    false    6            �            1259    26997    tb_paytype_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_paytype_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.tb_paytype_type_id_seq;
       public          postgres    false    232    6            �           0    0    tb_paytype_type_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.tb_paytype_type_id_seq OWNED BY public.tb_paytype.type_id;
          public          postgres    false    231            �            1259    16566    tb_role    TABLE     c   CREATE TABLE public.tb_role (
    role_id integer NOT NULL,
    role_name character varying(30)
);
    DROP TABLE public.tb_role;
       public         heap    postgres    false    6            �            1259    16569    tb_role_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_role_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tb_role_role_id_seq;
       public          postgres    false    6    226            �           0    0    tb_role_role_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tb_role_role_id_seq OWNED BY public.tb_role.role_id;
          public          postgres    false    227            �            1259    16563    tb_structure    TABLE     �   CREATE TABLE public.tb_structure (
    struct_dish_id integer NOT NULL,
    struct_product_id integer NOT NULL,
    struct_weight integer
);
     DROP TABLE public.tb_structure;
       public         heap    postgres    false    6            �            1259    16570    tb_user    TABLE     �  CREATE TABLE public.tb_user (
    user_id integer NOT NULL,
    user_firstname character varying(20) NOT NULL,
    user_lastname character varying(30) NOT NULL,
    user_patronymic character varying(50),
    user_birthday date,
    user_login character varying(3) NOT NULL,
    user_password character varying(130) NOT NULL,
    user_phone character varying(10),
    user_address character varying(50),
    user_role_id integer DEFAULT 3
);
    DROP TABLE public.tb_user;
       public         heap    postgres    false    6            �            1259    26953    tb_user_data    TABLE     �   CREATE TABLE public.tb_user_data (
    user_id integer,
    user_passport_ser integer,
    user_passport_num integer,
    user_who_issued character varying(200),
    user_issue_date date,
    user_email character varying(320)
);
     DROP TABLE public.tb_user_data;
       public         heap    postgres    false    6            �            1259    16574    tb_user_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tb_user_user_id_seq;
       public          postgres    false    228    6            �           0    0    tb_user_user_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tb_user_user_id_seq OWNED BY public.tb_user.user_id;
          public          postgres    false    229            �           2604    26960    tb_dish dish_id    DEFAULT     q   ALTER TABLE ONLY public.tb_dish ALTER COLUMN dish_id SET DEFAULT nextval('public.dishes_dish_id_seq'::regclass);
 >   ALTER TABLE public.tb_dish ALTER COLUMN dish_id DROP DEFAULT;
       public          postgres    false    220    219            �           2604    26958    tb_dish_base base_id    DEFAULT     y   ALTER TABLE ONLY public.tb_dish_base ALTER COLUMN base_id SET DEFAULT nextval('public.dish_base_base_id_seq'::regclass);
 C   ALTER TABLE public.tb_dish_base ALTER COLUMN base_id DROP DEFAULT;
       public          postgres    false    216    215            �           2604    26959    tb_dish_type type_id    DEFAULT     z   ALTER TABLE ONLY public.tb_dish_type ALTER COLUMN type_id SET DEFAULT nextval('public.dish_types_type_id_seq'::regclass);
 C   ALTER TABLE public.tb_dish_type ALTER COLUMN type_id DROP DEFAULT;
       public          postgres    false    218    217            �           2604    27008    tb_order order_id    DEFAULT     v   ALTER TABLE ONLY public.tb_order ALTER COLUMN order_id SET DEFAULT nextval('public.tb_order_order_id_seq'::regclass);
 @   ALTER TABLE public.tb_order ALTER COLUMN order_id DROP DEFAULT;
       public          postgres    false    233    234    234            �           2604    27001    tb_paytype type_id    DEFAULT     x   ALTER TABLE ONLY public.tb_paytype ALTER COLUMN type_id SET DEFAULT nextval('public.tb_paytype_type_id_seq'::regclass);
 A   ALTER TABLE public.tb_paytype ALTER COLUMN type_id DROP DEFAULT;
       public          postgres    false    231    232    232            �           2604    26961    tb_product prod_id    DEFAULT     v   ALTER TABLE ONLY public.tb_product ALTER COLUMN prod_id SET DEFAULT nextval('public.products_prod_id_seq'::regclass);
 A   ALTER TABLE public.tb_product ALTER COLUMN prod_id DROP DEFAULT;
       public          postgres    false    222    221            �           2604    26962    tb_recipe recipe_id    DEFAULT     w   ALTER TABLE ONLY public.tb_recipe ALTER COLUMN recipe_id SET DEFAULT nextval('public.recipe_recipe_id_seq'::regclass);
 B   ALTER TABLE public.tb_recipe ALTER COLUMN recipe_id DROP DEFAULT;
       public          postgres    false    224    223            �           2604    26963    tb_role role_id    DEFAULT     r   ALTER TABLE ONLY public.tb_role ALTER COLUMN role_id SET DEFAULT nextval('public.tb_role_role_id_seq'::regclass);
 >   ALTER TABLE public.tb_role ALTER COLUMN role_id DROP DEFAULT;
       public          postgres    false    227    226            �           2604    26964    tb_user user_id    DEFAULT     r   ALTER TABLE ONLY public.tb_user ALTER COLUMN user_id SET DEFAULT nextval('public.tb_user_user_id_seq'::regclass);
 >   ALTER TABLE public.tb_user ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    229    228            e          0    16549    tb_dish 
   TABLE DATA           ]   COPY public.tb_dish (dish_id, dish_name, dish_type_id, dish_base_id, dish_image) FROM stdin;
    public          postgres    false    219   q�       a          0    16541    tb_dish_base 
   TABLE DATA           E   COPY public.tb_dish_base (base_id, base_name, base_exit) FROM stdin;
    public          postgres    false    215   �       c          0    16545    tb_dish_type 
   TABLE DATA           :   COPY public.tb_dish_type (type_id, type_name) FROM stdin;
    public          postgres    false    217   ��       t          0    27005    tb_order 
   TABLE DATA           h   COPY public.tb_order (order_id, order_user_id, order_address, order_date, order_paytype_id) FROM stdin;
    public          postgres    false    234   ΅       u          0    27025    tb_order_cart 
   TABLE DATA           U   COPY public.tb_order_cart (cart_order_id, cart_prod_id, cart_prod_count) FROM stdin;
    public          postgres    false    235   �       r          0    26998 
   tb_paytype 
   TABLE DATA           8   COPY public.tb_paytype (type_id, type_name) FROM stdin;
    public          postgres    false    232   �       g          0    16553 
   tb_product 
   TABLE DATA           ^   COPY public.tb_product (prod_id, prod_name, prod_protein, prod_fats, prod_carboh) FROM stdin;
    public          postgres    false    221   %�       i          0    16557 	   tb_recipe 
   TABLE DATA           F   COPY public.tb_recipe (recipe_id, dishes_id, recipe_text) FROM stdin;
    public          postgres    false    223   ��       l          0    16566    tb_role 
   TABLE DATA           5   COPY public.tb_role (role_id, role_name) FROM stdin;
    public          postgres    false    226   s�       k          0    16563    tb_structure 
   TABLE DATA           X   COPY public.tb_structure (struct_dish_id, struct_product_id, struct_weight) FROM stdin;
    public          postgres    false    225   ш       n          0    16570    tb_user 
   TABLE DATA           �   COPY public.tb_user (user_id, user_firstname, user_lastname, user_patronymic, user_birthday, user_login, user_password, user_phone, user_address, user_role_id) FROM stdin;
    public          postgres    false    228   �       p          0    26953    tb_user_data 
   TABLE DATA           �   COPY public.tb_user_data (user_id, user_passport_ser, user_passport_num, user_who_issued, user_issue_date, user_email) FROM stdin;
    public          postgres    false    230   5�       �           0    0    dish_base_base_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.dish_base_base_id_seq', 17, true);
          public          postgres    false    216            �           0    0    dish_types_type_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.dish_types_type_id_seq', 6, true);
          public          postgres    false    218            �           0    0    dishes_dish_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.dishes_dish_id_seq', 59, true);
          public          postgres    false    220            �           0    0    products_prod_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.products_prod_id_seq', 31, true);
          public          postgres    false    222            �           0    0    recipe_recipe_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.recipe_recipe_id_seq', 39, true);
          public          postgres    false    224            �           0    0    tb_order_order_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tb_order_order_id_seq', 1, false);
          public          postgres    false    233            �           0    0    tb_paytype_type_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.tb_paytype_type_id_seq', 1, false);
          public          postgres    false    231            �           0    0    tb_role_role_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.tb_role_role_id_seq', 3, true);
          public          postgres    false    227            �           0    0    tb_user_user_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tb_user_user_id_seq', 59, true);
          public          postgres    false    229            �           2606    16583    tb_dish_base dish_base_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tb_dish_base
    ADD CONSTRAINT dish_base_pkey PRIMARY KEY (base_id);
 E   ALTER TABLE ONLY public.tb_dish_base DROP CONSTRAINT dish_base_pkey;
       public            postgres    false    215            �           2606    16585    tb_dish_type dish_types_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.tb_dish_type
    ADD CONSTRAINT dish_types_pkey PRIMARY KEY (type_id);
 F   ALTER TABLE ONLY public.tb_dish_type DROP CONSTRAINT dish_types_pkey;
       public            postgres    false    217            �           2606    16587    tb_dish dishes_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tb_dish
    ADD CONSTRAINT dishes_pkey PRIMARY KEY (dish_id);
 =   ALTER TABLE ONLY public.tb_dish DROP CONSTRAINT dishes_pkey;
       public            postgres    false    219            �           2606    16589    tb_product products_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.tb_product
    ADD CONSTRAINT products_pkey PRIMARY KEY (prod_id);
 B   ALTER TABLE ONLY public.tb_product DROP CONSTRAINT products_pkey;
       public            postgres    false    221            �           2606    16591    tb_recipe recipe_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.tb_recipe
    ADD CONSTRAINT recipe_pkey PRIMARY KEY (recipe_id);
 ?   ALTER TABLE ONLY public.tb_recipe DROP CONSTRAINT recipe_pkey;
       public            postgres    false    223            �           2606    16593    tb_structure scructure_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.tb_structure
    ADD CONSTRAINT scructure_pkey PRIMARY KEY (struct_dish_id, struct_product_id);
 E   ALTER TABLE ONLY public.tb_structure DROP CONSTRAINT scructure_pkey;
       public            postgres    false    225    225            �           2606    27011    tb_order tb_order_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.tb_order
    ADD CONSTRAINT tb_order_pkey PRIMARY KEY (order_id);
 @   ALTER TABLE ONLY public.tb_order DROP CONSTRAINT tb_order_pkey;
       public            postgres    false    234            �           2606    27003    tb_paytype tb_paytype_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.tb_paytype
    ADD CONSTRAINT tb_paytype_pkey PRIMARY KEY (type_id);
 D   ALTER TABLE ONLY public.tb_paytype DROP CONSTRAINT tb_paytype_pkey;
       public            postgres    false    232            �           2606    16595    tb_role tb_role_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.tb_role
    ADD CONSTRAINT tb_role_pkey PRIMARY KEY (role_id);
 >   ALTER TABLE ONLY public.tb_role DROP CONSTRAINT tb_role_pkey;
       public            postgres    false    226            �           2606    16597    tb_user tb_user_login_key 
   CONSTRAINT     Z   ALTER TABLE ONLY public.tb_user
    ADD CONSTRAINT tb_user_login_key UNIQUE (user_login);
 C   ALTER TABLE ONLY public.tb_user DROP CONSTRAINT tb_user_login_key;
       public            postgres    false    228            �           2606    16599    tb_user tb_user_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.tb_user
    ADD CONSTRAINT tb_user_pkey PRIMARY KEY (user_id);
 >   ALTER TABLE ONLY public.tb_user DROP CONSTRAINT tb_user_pkey;
       public            postgres    false    228            �           2620    26965    tb_user tr_insert_user    TRIGGER     {   CREATE TRIGGER tr_insert_user AFTER INSERT ON public.tb_user FOR EACH ROW EXECUTE FUNCTION public.trigger_user_userdata();
 /   DROP TRIGGER tr_insert_user ON public.tb_user;
       public          postgres    false    246    228            �           2606    16600     tb_dish dishes_dish_base_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_dish
    ADD CONSTRAINT dishes_dish_base_id_fkey FOREIGN KEY (dish_base_id) REFERENCES public.tb_dish_base(base_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.tb_dish DROP CONSTRAINT dishes_dish_base_id_fkey;
       public          postgres    false    3251    219    215            �           2606    16605     tb_dish dishes_dish_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_dish
    ADD CONSTRAINT dishes_dish_type_id_fkey FOREIGN KEY (dish_type_id) REFERENCES public.tb_dish_type(type_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.tb_dish DROP CONSTRAINT dishes_dish_type_id_fkey;
       public          postgres    false    219    217    3253            �           2606    16610    tb_recipe recipe_dishes_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_recipe
    ADD CONSTRAINT recipe_dishes_id_fkey FOREIGN KEY (dishes_id) REFERENCES public.tb_dish(dish_id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.tb_recipe DROP CONSTRAINT recipe_dishes_id_fkey;
       public          postgres    false    3255    219    223            �           2606    16615 %   tb_structure scructure_dishes_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_structure
    ADD CONSTRAINT scructure_dishes_id_fkey FOREIGN KEY (struct_dish_id) REFERENCES public.tb_dish(dish_id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.tb_structure DROP CONSTRAINT scructure_dishes_id_fkey;
       public          postgres    false    225    3255    219            �           2606    16620 '   tb_structure scructure_products_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_structure
    ADD CONSTRAINT scructure_products_id_fkey FOREIGN KEY (struct_product_id) REFERENCES public.tb_product(prod_id);
 Q   ALTER TABLE ONLY public.tb_structure DROP CONSTRAINT scructure_products_id_fkey;
       public          postgres    false    225    221    3257            �           2606    27028 .   tb_order_cart tb_order_cart_cart_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_order_cart
    ADD CONSTRAINT tb_order_cart_cart_order_id_fkey FOREIGN KEY (cart_order_id) REFERENCES public.tb_order(order_id);
 X   ALTER TABLE ONLY public.tb_order_cart DROP CONSTRAINT tb_order_cart_cart_order_id_fkey;
       public          postgres    false    234    3271    235            �           2606    27033 -   tb_order_cart tb_order_cart_cart_prod_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_order_cart
    ADD CONSTRAINT tb_order_cart_cart_prod_id_fkey FOREIGN KEY (cart_prod_id) REFERENCES public.tb_product(prod_id);
 W   ALTER TABLE ONLY public.tb_order_cart DROP CONSTRAINT tb_order_cart_cart_prod_id_fkey;
       public          postgres    false    221    3257    235            �           2606    27017 '   tb_order tb_order_order_paytype_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_order
    ADD CONSTRAINT tb_order_order_paytype_id_fkey FOREIGN KEY (order_paytype_id) REFERENCES public.tb_paytype(type_id);
 Q   ALTER TABLE ONLY public.tb_order DROP CONSTRAINT tb_order_order_paytype_id_fkey;
       public          postgres    false    3269    234    232            �           2606    27012 $   tb_order tb_order_order_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_order
    ADD CONSTRAINT tb_order_order_user_id_fkey FOREIGN KEY (order_user_id) REFERENCES public.tb_user(user_id);
 N   ALTER TABLE ONLY public.tb_order DROP CONSTRAINT tb_order_order_user_id_fkey;
       public          postgres    false    228    3267    234            �           2606    16625 !   tb_user tb_user_user_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_user
    ADD CONSTRAINT tb_user_user_role_id_fkey FOREIGN KEY (user_role_id) REFERENCES public.tb_role(role_id);
 K   ALTER TABLE ONLY public.tb_user DROP CONSTRAINT tb_user_user_role_id_fkey;
       public          postgres    false    228    226    3263            e   �  x�eQKn�0\S�z� v~/Gxw�F��X�e�ݢ�4E�e��
�M�3�7z����B93$g�0y���})$0�d��آͲ��=���'W�%kЪƎ�Ȯ云��,�h�����{>�qw�ݗǂH� Ѷ5Znt]�V�;b��Ó{�ߑ4�I�#��W
�������Q����(�~܇��?�����紽{u�aG�oq`P(��Qli��4��Vt����RĖ��ee���%RXAnP�0 K�A���A����V׶��xl	�y���g	I	c��cd�TH�@;��sQ�%���)�R4F[߹$4Ѿ(d�����FgϝA���4%�+�J��~�ͦƑ��K�6<��f�*�j��.���ڈ��)�Z���	(YW�0��"�l�����      a   X   x��A� �γ�1��/jv�1��nmS�,�`��� mۓ�Fh�gG���&H�3�%�6L�<]���UE��}x��      c   ;   x�3�,�KL�.�2�,�/-�2���/�2�LI-N-*�2�L)��J�q���r��qqq ���      t      x������ � �      u      x������ � �      r      x������ � �      g   �   x�OKr�0[��t ��t㗒L�I��I�}i�� !	��l�L�L��m 3&M�L	����D
e�����Љ
�m�v������ϭ��FM$����v!�(*�bf��T)��m6vR)�$b��3 ����.��߻y^O䬌�Y�����D�:�e1�2*�?�N/8�H��_<_������AD�>�;c      i   n  x�u�]J�P��'��
B��ً/B��@҂E*�A�+����h��n��\��ޤR����{��ܹ���'Tآ��f:��^�PB�s�P`�#�f��9�D�ޘ_��!�Xp�c�Q�X�V#$�f,Phs�\�Бk�XE�`�>�\*���)���;�i2�%�d}?bgY��fVlcc�Xf:2��+��R"ͨ_����.��	�=n�J�ܱ�(�Ɇ�������j�K+�B0=���in5��,����LʙX�XX-� ��	��M'T�߹�XG.>;��!�������[-�$^5��Z�%ox�^*�Q��[��W��+��G��b���v{�w���9����zT�      l   N   x����0�����w8&T��X!�:@y���l��!�q�Py��xv�x��ʘرˍ��G����8cU�{���+�      k   6  x�5R��!;c1�E�^~�ul�$BH��n�{;"�/�6p��}�ݗ-�ZL�� @X�̣���i�}���ԅ�7@m�B���-�F��	�����#n�,DI����a�BpTr�Z���f&�K��Ͽ�3K�+�X"M�R$�y�\��+�������Ǥ�[�p�m{����0:}�$��Rpo;IDgD%����ڻl �dٽe�l��
M�GA���E*q�3���)��:���O�j\��e{?��VC���,�x��_�F���v��.��~`�X��y��Ӯ���ϸ����������m�      n     x�͖�n\E��=O��U�W�B(�"�b�Muw��@l�X�H��BHV,���LB�+�y#��0f�U,k�<���S�;uMn�n9��\,O���-�,���������ڇ�b���Z��Ӗؽw�M�c�l%�,�$H96Mbk�,�K�#dna�^��2���d��QF4AJ1ck#�l��/�[H���b�Z�球�-�<]e*Rc��_!����~��g�9[�/=�t����у���Gy�[�[J���7�������}�h��4���nuvdb=����a��e�n�u#<��JWy��[~�_,g�39[�������/(q }[�;���H��v'(��#�dg�|~թ�����	>>;Np�_N~�Ӗ��}z%�U���W��m]V*m)�۷`�Q��j�$��.�7�,�J�D�������/E!��8}֢��W��kH���ub,�H��4�\zKI���T\��.֠�+w���h����by�xh���k�����M�x����W�����dN�Eq��̃�����%�?�wN��s/�URJM�����D�z��͛�*�q�E�/VG�Ă�6L.�l*\�؈^�Cc�>&��PT�?6�j�^�`1#�ظB�	j��y?��ɨ���w�����5�U���R�R�0�R�v�1J�u4ch�2����� SC�]1c��'� d8:��a�~�,�t��9m6���S�M*��W������/���d����CVD���@2�H�Q;��d��-��<i�]s��y��3�)@鈩���R�"N�W0�y���i�����/W��%'��+��a`5��c'��%��hTQ�b($w�YhdJ�#{��i*H��CS0HS�#�D��7�9�gPC���;��z+V0�v����7�^>K<=u��K�<�*�&a���Й�̡L�ر*��,�c�)���{DS�fF�5I-h�D�Z��e&�%ERF|i�
�ކQ���o����@XoT��3�y�<:��7B:����}|���X�}4�(�{�m6� ����      p   /  x���Mn�0F�㻀�O�q�� Z�%�%��;����Ҫ�G���0�̧�ļI@w�:�\��L�048T��=�adJ�ҋ����Ԅ�l��Fl�om�V��θʸ�-�b�&���f��S;��:����k��-�/?1w�`�oj����.i�hLJk���w����C;F=Ntތ��ġ~MV��C1���y�H6���P;Zȴ�%)Q���s�]�|�x��o]<,�y��H���p�Ҩ�7�QaF$� &7��`�#K_Yq��c=�����U�'l���Q1	(���r��9c��@�x     