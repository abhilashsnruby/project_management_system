require 'spreadsheet'
namespace :import do
  desc "Import sites from Excel"
  task sites: :environment do
    filename = File.join Rails.root, "sites.xls"
    excel = Spreadsheet.open filename
    sheet = excel.worksheet 0
    sheet.each do |item|
      value = { name: item[0],party_id: item[1], party: item[2],country:item[3],city:item[4] }
      Site.create(value)
    end
  end
end
