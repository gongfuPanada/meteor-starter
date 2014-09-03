Schemas = {}

Words = new Meteor.Collection('words')

Schemas.WordsAttempts = new SimpleSchema
	date:
		type: Date
	start:
		type: Number
	end:
		type: Number

Schemas.Words = new SimpleSchema
	source:
		type:String
		max: 200

	target:
		type: String
		max: 200

	transliteration:
		type: String
		max: 200
		optional: true

	level:
		type: Number
		autoValue: ->
			if @isInsert
				true

	mem:
		type: [String]

	content:
		type: String
		autoform:
			rows: 5

	createdAt: 
		type: Date
		autoValue: ->
			if this.isInsert
				new Date()

	updatedAt:
		type:Date
		optional:true
		autoValue: ->
			if this.isUpdate
				new Date()
	owner: 
		type: String
		regEx: SimpleSchema.RegEx.Id
		autoValue: ->
			if this.isInsert
				Meteor.userId()

		autoform:
			options: ->
				_.map Meteor.users.find().fetch(), (user)->
					label: user.emails[0].address
					value: user._id

Words.attachSchema(Schemas.Words)

if Meteor.isClient
	window.Words = Words
else if Meteor.isServer
	global.Words = Words