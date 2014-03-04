
this.SurveyQuestionCollection = new Meteor.Collection 'SurveyQuestion'
this.SurveyEnumeratedResponseCollection = new Meteor.Collection 'SurveyEnumeratedResponse'

class this.SurveyQuestionModel extends Model
  collection: SurveyQuestionCollection

  defaults:
    answer: null
