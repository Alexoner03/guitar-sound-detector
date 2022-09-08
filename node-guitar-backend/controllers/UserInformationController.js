const express = require("express");
const router = express.Router();
const UserModel = require("../models/UserInfoModel");

router.get("/", async (req, res) => {
    const { email } = req.query;

    if (!email) {
        res.status(400).json({
            message: "Ingrese email",
        });
    }

    const user = await UserModel.findOne({ email }).exec();

    res.json(user);
});

router.post("/", async (req, res) => {
    const body = req.body;
    const user = await UserModel.create(body);
    res.json(user);
});

router.put("/chords", async (req, res) => {
    const body = req.body;
    if (!body.chords && body.chords.length < 7) {
        res.status(400).json({
            message: "Ingrese Chords correctamente",
        });
    }
    const user = await UserModel.findOne({ email: body.email }).exec();
    body.chords.map((c, index) => {
        if (c.score < user.chords[index].score) {
            c.score = user.chords[index].score;
        }

        return c;
    });

    user.chords = body.chords;
    await user.save();
    res.json(user);
});

router.put("/notes", async (req, res) => {
    const body = req.body;
    if (!body.notes && body.notes.length < 6) {
        res.status(400).json({
            message: "Ingrese Notes correctamente",
        });
    }
    const user = await UserModel.findOne({ email: body.email }).exec();

    body.notes.map((c, index) => {
        if (c.score < user.notes[index].score) {
            c.score = user.notes[index].score;
        }

        return c;
    });
    user.notes = body.notes;
    await user.save();
    res.json(user);
});

router.put("/tests", async (req, res) => {
    const body = req.body;
    if (!body.tests && body.tests.length < 3) {
        res.status(400).json({
            message: "Ingrese tests correctamente",
        });
    }

    const user = await UserModel.findOne({ email: body.email }).exec();

    body.tests.map((c, index) => {
        if (c.score < user.tests[index].score) {
            c.score = user.tests[index].score;
        }

        return c;
    });
    user.tests = body.tests;
    await user.save();
    res.json(user);
});

module.exports = router;
