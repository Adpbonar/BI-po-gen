# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email: "info@bonarinstitute.com", password: "Bi1123581321!")

10.times do
    Participant.create(name: Faker::Name.unique.name, emailaddress: Faker::Internet.email, type: 'Associate')
end

10.times do
    Participant.create(name: Faker::Name.unique.name, emailaddress: Faker::Internet.email, type: 'Client')
end

# Service Items

SavedService.create(title: "Customized Coaching & Mentoring-Advisors Program - Mid-Level Leaders & Entrepreneurs", description: "<p>Features: 14 sessions over 6 months</p>Icluding:<ul><li>Preperation</li><li>Discovery</li><li>coaching sessions & consultations</li><li>Coaching sessions & consultations</li><li>Access to resources</li><li>A progress report</li><li>A final report</li></ul>", cost: 10000, taxable: true)
SavedService.create(title: "Customized Coaching & Mentoring-Advisors Program - Senior Leaders & Entrepreneurs", description: "<p>Features: 14 sessions over 6 months</p>Icluding:<ul><li>Preperation</li><li>Discovery</li><li>coaching sessions & consultations</li><li>Coaching sessions & consultations</li><li>Access to resources</li><li>A progress report</li><li>A final report</li></ul>", cost: 12000, taxable: true)
SavedService.create(title: "Customized Coaching & Mentoring-Advisors Program - C-Suite", description: "<p>Features: 14 sessions over 6 months</p>Icluding:<ul><li>Preperation</li><li>Discovery</li><li>coaching sessions & consultations</li><li>Coaching sessions & consultations</li><li>Access to resources</li><li>A progress report</li><li>A final report</li></ul>", cost: 15000, taxable: true, type:"SavedService")

SavedService.create(title: "Customized Coaching & Mentoring-Advisors Program - Mid-Level Leaders & Entrepreneurs", description: "<p>Features: 20 sessions over 9 months</p>Icluding:<ul><li>Preperation</li><li>Discovery</li><li>coaching sessions & consultations</li><li>Coaching sessions & consultations</li><li>Access to resources</li><li>A progress report</li><li>A final report</li></ul>", cost: 12000, taxable: true)
SavedService.create(title: "Customized Coaching & Mentoring-Advisors Program - Senior Leaders & Entrepreneurs", description: "<p>Features: 20 sessions over 9 months</p>Icluding:<ul><li>Preperation</li><li>Discovery</li><li>coaching sessions & consultations</li><li>Coaching sessions & consultations</li><li>Access to resources</li><li>A progress report</li><li>A final report</li></ul>", cost: 15000, taxable: true)
SavedService.create(title: "Customized Coaching & Mentoring-Advisors Program - C-Suite", description: "<p>Features: 20 sessions over 9 months</p>Icluding:<ul><li>Preperation</li><li>Discovery</li><li>coaching sessions & consultations</li><li>Coaching sessions & consultations</li><li>Access to resources</li><li>A progress report</li><li>A final report</li></ul>", cost: 20000, taxable: true)

SavedService.create(title: "Customized Coaching & Mentoring-Advisors Program - Mid-Level Leaders & Entrepreneurs", description: "<p>Features: 24 sessions over 12 months</p>Icluding:<ul><li>Added flexibility, with sessions available as needed</li><li>Preperation</li><li>Discovery</li><li>coaching sessions & consultations</li><li>Coaching sessions & consultations</li><li>Access to resources</li><li>A progress report</li><li>A final report</li></ul>", cost: 15000, taxable: true)
SavedService.create(title: "Customized Coaching & Mentoring-Advisors Program - Senior Leaders & Entrepreneurs", description: "<p>Features: 24 sessions over 12 months</p>Icluding:<ul><li>Added flexibility, with sessions available as needed</li><li>Preperation</li><li>Discovery</li><li>coaching sessions & consultations</li><li>Coaching sessions & consultations</li><li>Access to resources</li><li>A progress report</li><li>A final report</li></ul>", cost: 19000, taxable: true)
SavedService.create(title: "Customized Coaching & Mentoring-Advisors Program - C-Suite", description: "<p>Features: 24 sessions over 12 months</p>Icluding:<ul><li>Added flexibility, with sessions available as needed</li><li>Preperation</li><li>Discovery</li><li>coaching sessions & consultations</li><li>Coaching sessions & consultations</li><li>Access to resources</li><li>A progress report</li><li>A final report</li></ul>", cost: 24000, taxable: true)

SavedService.create(title: "A ½ Day of Training & Presentations - Mid-Level Leaders & Entrepreneurs", description: "<p>Features a ½ day event designed specifically for mid-level leaders & entrepreneurs and facilitated by our team of associates on a designated topic.</p>", cost: 5000, taxable: true)
SavedService.create(title: "A ½ Day of Training & Presentations - Senior Leaders & Entrepreneurs", description: "<p>Features a ½ day event designed specifically for senior leaders & entrepreneurs and facilitated by our team of associates on a designated topic.</p>", cost: 7000, taxable: true)
SavedService.create(title: "A ½ Day of Training & Presentations - C-Suite", description: "<p>Features a ½ day event designed specifically for your C-Suite and facilitated by our team of associates on a designated topic.</p>", cost: 9000, taxable: true)

SavedService.create(title: "1 Day of Training & Presentations - Mid-Level Leaders & Entrepreneurs", description: "<p>Features a 1 day event designed specifically for mid-level leaders & entrepreneurs and facilitated by our team of associates on a designated topic.</p>", cost: 9000, taxable: true)
SavedService.create(title: "1 Day of Training & Presentations - Senior Leaders & Entrepreneurs", description: "<p>Features a 1 day event designed specifically for senior leaders & entrepreneurs and facilitated by our team of associates on a designated topic.</p>", cost: 12000, taxable: true)
SavedService.create(title: "1 Day of Training & Presentations - C-Suite", description: "<p>Features a 1 day event designed specifically for your C-Suite and facilitated by our team of associates on a designated topic.</p>", cost: 15000, taxable: true)

SavedService.create(title: "2 Days of Training & Presentations - Mid-Level Leaders & Entrepreneurs", description: "<p>Features a 2 day event designed specifically for mid-level leaders & entrepreneurs and facilitated by our team of associates on a designated topic.</p>", cost: 9000, taxable: true)
SavedService.create(title: "2 Days of Training & Presentations - Senior Leaders & Entrepreneurs", description: "<p>Features a 2 day event designed specifically for senior leaders & entrepreneurs and facilitated by our team of associates on a designated topic.</p>", cost: 12000, taxable: true)
SavedService.create(title: "2 Days of Training & Presentations - C-Suite", description: "<p>Features a 2 day event designed specifically for your C-Suite and facilitated by our team of associates on a designated topic.</p>", cost: 15000, taxable: true)

SavedService.create(title: "Consulting Engagement: 1 week diagnosis - Senior Leaders & Entrepreneurs", cost: 13500, taxable: true)
SavedService.create(title: "Consulting Engagement: 1 week diagnosis - C-Suite", cost: 1500, taxable: true)

SavedService.create(title: "Consulting Engagement: 4 weeks - Senior Leaders & Entrepreneurs", cost: 40000, taxable: true)
SavedService.create(title: "Consulting Engagement: 4 weeks - C-Suite", cost: 60000, taxable: true)

# Expense Items

SavedExpense.create(title: "EQ360 - Senior Leaders & Entrepreneurs", description: "<p><b>Charged per individual</b></p><p>Icludes:<ul><li>Preperation</li><li>A debrief</li></ul>", cost: 1200, taxable: true, expense_cost: 325.0)
SavedExpense.create(title: "EQ360 - C-Suite", description: "<p><b>Charged per individual</b></p><p>Icludes:<ul><li>Preperation</li><li>A debrief</li></ul>", cost: 1500, taxable: true, expense_cost: 325.0)

SavedExpense.create(title: "EQI 2.0 Leadership Report - Senior Leaders & Entrepreneurs", description: "<p>Icludes:<ul><li>Preperation</li><li>A debrief</li></ul>", cost: 1000, taxable: true, expense_cost: 100.0)
SavedExpense.create(title: "EQI 2.0 Leadership Report - C-Suite", description: "<p>Icludes:<ul><li>Preperation</li><li>A debrief</li></ul>", cost: 1250, taxable: true, expense_cost: 100.0)

SavedExpense.create(title: "EQI 2.0 Group Report - Senior Leaders & Entrepreneurs", description: "<p>Icludes:<ul><li>Preperation</li><li>A debrief</li></ul>", cost: 1000, taxable: true, expense_cost: 250.0)
SavedExpense.create(title: "EQI 2.0 Group Report - C-Suite", description: "<p>Icludes:<ul><li>Preperation</li><li>A debrief</li></ul>", cost: 1250, taxable: true, expense_cost: 250.0)

SavedExpense.create(title: "Oral 360 - Senior Leaders & Entrepreneurs", description: "<p>Icludes:<ul><li>Preperation</li><li>A debrief</li></ul>", cost: 1500, taxable: true)
SavedExpense.create(title: "Oral 360 - C-Suite", description: "<p>Icludes:<ul><li>Preperation</li><li>A debrief</li></ul>", cost: 2000, taxable: true)

Statement.all.each do |s|
    2.times do 
        ServiceItem.create(statement_id: s.id, title: "Coaching", description: "Coaching for Devan", cost: 2000)
    end
    2.times do 
        ExpenseItem.create(statement_id: s.id, title: "Assessments", description: "Assessments for Devan", cost: 2000)
    end
end

# Company

Company.create(company_name: 'Bonar Institute for Purposeful Leadership Inc.', address: 'C/O James Bonar<br />355 Lyon Street North, Ottawa, ON, Canada<br />K1R 5W8')