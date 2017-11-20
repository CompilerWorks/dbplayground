-- psql -U testuser -d test -f this_file.sql
create schema test;
use test;
create table a (a0 int, a1 int, a2 int, a3 int, a4 int, a5 int, a6 int, a7 int);
create table b (b0 int, b1 int, b2 int, b3 int, b4 int, b5 int, b6 int, b7 int);
create table c (c0 int, c1 int, c2 int, c3 int);
create table d (d0 int, d1 int, d2 int, d3 int);
create table p (p0 int, p1 int, p2 varchar(200), p3 varchar(200), p4 boolean, p5 boolean);
