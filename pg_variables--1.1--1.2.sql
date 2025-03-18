/* contrib/pg_variables/pg_variables--1.1--1.2.sql */

-- complain if script is sourced in psql, rather than via ALTER EXTENSION
\echo Use "ALTER EXTENSION pg_variables UPDATE TO '1.2'" to load this file. \quit

-- Functions to work with arrays

CREATE FUNCTION pgv_set(package text, name text, value anyarray, is_transactional bool default false)
RETURNS void
AS 'MODULE_PATHNAME', 'variable_set_array'
LANGUAGE C VOLATILE;

CREATE FUNCTION pgv_get(package text, name text, var_type anyarray, strict bool default true)
RETURNS anyarray
AS 'MODULE_PATHNAME', 'variable_get_array'
LANGUAGE C VOLATILE;

CREATE OR REPLACE FUNCTION pgv_select_support(internal) RETURNS internal
    LANGUAGE c
    AS 'MODULE_PATHNAME', 'variable_select_support';

CREATE OR REPLACE FUNCTION FUNCTION pgv_select(package text, name text)
RETURNS setof record SUPPORT pgv_select_support
AS 'MODULE_PATHNAME', 'variable_select'
LANGUAGE C VOLATILE;