const validations = require.context('.', true, /_validations\.js$/)
validations.keys().forEach(validations)
