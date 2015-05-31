#!/usr/bin/env node

'use strict';

var repeat = require('repeat-string')
    , bPromise = require('bluebird')
    , bStreamToBuffer = bPromise.promisify(require('stream-to-buffer'));

bStreamToBuffer(process.stdin)
    .then(function(selected) {
        console.log('//' + repeat('-', selected.length + 2) + '//');
        console.log('// ' + selected + ' //');
        console.log('//' + repeat('-', selected.length + 2) + '//');
    });
