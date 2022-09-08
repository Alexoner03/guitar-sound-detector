const mongoose = require('mongoose')

const {Schema} = mongoose;

const SoundSchema = new Schema({
    _id: false,
    name : String,
    passed: Boolean,
    score: {
        type : Number,
        get : v => v.toFixed(2)
    }
})

const TestSchema = new Schema({
    _id : false,
    level : {
        type : String,
        enum : ["one","two","three"]
    },
    score : {
        type : Number,
        get : v => v.toFixed(2)
    }
})

const userSchema = new Schema({
        email : String,
        notes : {
            type : [SoundSchema],
            default :  [
                {
                    "name" : "A",
                    "passed": false,
                    "score" : 0
                },
                {
                    "name" : "B",
                    "passed": false,
                    "score" : 0
                },
                {
                    "name" : "D",
                    "passed": false,
                    "score" : 0
                },
                {
                    "name" : "E",
                    "passed": false,
                    "score" : 0
                },
                {
                    "name" : "Egrave",
                    "passed": false,
                    "score" : 0
                },
                {
                    "name" : "G",
                    "passed": false,
                    "score" : 0
                }
            ]
        },
        chords : {
            type : [SoundSchema],
            default : [
                {
                    "name" : "Do",
                    "passed": false,
                    "score" : 0
                },
                {
                    "name" : "Fa",
                    "passed": false,
                    "score" : 0
                },
                {
                    "name" : "La",
                    "passed": false,
                    "score" : 0
                },
                {
                    "name" : "Mi",
                    "passed": false,
                    "score" : 0
                },
                {
                    "name" : "Re",
                    "passed": false,
                    "score" : 0
                },
                {
                    "name" : "Si",
                    "passed": false,
                    "score" : 0
                },
                {
                    "name" : "Sol",
                    "passed": false,
                    "score" : 0
                }
            ]
        },
        tests : {
            type: [TestSchema],
            default: [
                {
                    level : "one",
                    score: 0
                },
                {
                    level : "two",
                    score: 0
                },
                {
                    level : "three",
                    score: 0
                },
            ]
        }
    }
);

module.exports = mongoose.model('user-info', userSchema);