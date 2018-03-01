from jinja2 import StrictUndefined

from flask import (Flask, render_template, redirect, request, flash,
                   session, jsonify)
from flask_debugtoolbar import DebugToolbarExtension

from model import connect_to_db, db, Category, Weather, Lift, Skirun, User, Rating, SkillLevel, CatUser
from random import sample
import json
import os


def blackcomb_flare_json():
    """creates json data for d3 map"""

    lifts = Lift.query.all()
    skiruns = Skirun.query.all()

    lifts_list = []

    for lift in lifts:
        if lift.mountain == 'Blackcomb':
            lift_dict = {}
            lift_dict['name'] = lift.name

            # query for the inner most mtn lift & skirun information
            mtn_query = '''SELECT json_agg(t)
                            FROM (
                            SELECT
                            s.name AS name
                            FROM lifts AS l
                            JOIN skiruns_lifts AS sl ON l.lift_id = sl.lift_id
                            JOIN skiruns As s ON sl.skirun_id = s.skirun_id
                            WHERE l.lift_id= :lift_id) t; '''

            lift_list = db.session.execute(mtn_query, {'lift_id': lift.lift_id})

            lift_list = lift_list.fetchall()

            # Inner most child
            lift_list = lift_list[0][0]

            lift_dict['children'] = lift_list
            # import pdb; pdb.set_trace()
            lifts_list.append(lift_dict)

        b_master_dict = {'name': 'Blackcomb', 'children': lifts_list}

    return b_master_dict


def whistler_flare_json():
    """creates json data for d3 map"""

    lifts = Lift.query.all()
    skiruns = Skirun.query.all()

    lifts_list = []

    for lift in lifts:
        if lift.mountain == 'Whistler':
            lift_dict = {}
            lift_dict['name'] = lift.name

            # query for the inner most mtn lift & skirun information
            mtn_query = '''SELECT json_agg(t)
                            FROM (
                            SELECT
                            s.name AS name
                            FROM lifts AS l
                            JOIN skiruns_lifts AS sl ON l.lift_id = sl.lift_id
                            JOIN skiruns As s ON sl.skirun_id = s.skirun_id
                            WHERE l.lift_id= :lift_id) t; '''

            lift_list = db.session.execute(mtn_query, {'lift_id': lift.lift_id})

            lift_list = lift_list.fetchall()

            # Inner most child
            lift_list = lift_list[0][0]

            lift_dict['children'] = lift_list
            # import pdb; pdb.set_trace()
            lifts_list.append(lift_dict)

        w_master_dict = {'name': 'Whistler', 'children': lifts_list}

    return w_master_dict
