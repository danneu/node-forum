exports = mongoose = require 'mongoose'
connString = "mongodb://localhost/symp_node_dev"
mongoose.connect(connString)
exports = Schema = mongoose.Schema
