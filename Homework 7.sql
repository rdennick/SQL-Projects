-- --------------------------------------------------------------------------------
-- Name: Ryan Dennick
-- Class: IT-111-400
-- Abstract: Homework 7 - 2NF Practice
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------CREATE TABLE TTeams (	 intTeamID			INTEGER			NOT NULL	,strTeam			VARCHAR(50)		NOT NULL	,strMascot			VARCHAR(50)		NOT NULL	,CONSTRAINT TTeams_PK PRIMARY KEY ( intTeamID ));
CREATE TABLE TTeamPlayers(	 intTeamID			INTEGER			NOT NULL	,intPlayerID		INTEGER			NOT NULL	,CONSTRAINT TTeamPlayers_PK PRIMARY KEY ( intTeamID, intPlayerID ));

CREATE TABLE TPlayers(	 intPlayerID		INTEGER			NOT NULL	,strFirstName		VARCHAR(50)		NOT NULL	,strLastNames		VARCHAR(50)		NOT NULL	,CONSTRAINT TPlayers_PK PRIMARY KEY ( intPlayerID ));

