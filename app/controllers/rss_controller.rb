require 'csv'
require 'iconv'
require 'open-uri'
require 'rss'

class RssController < ApplicationController
  def show
    respond_to do |format|
      format.csv do
        lines = open(params[:feed_url]) { |raw|
          feed = RSS::Parser.parse(raw)

          feed.entries.map { |item|
            enclosure = item.
              links.
              find { |l| l.rel == 'enclosure' }

            if enclosure
              url = enclosure.href

              updated = item.updated.content.to_date.iso8601
              source = clean(item.source.title.content)
              title = clean(item.title.content)
              extname = File.extname(url)

              filename = "#{updated} - #{source} - #{title}#{extname}"
              [filename, url].to_csv
            end
          }.compact
        }

        lines.unshift("name,url\n")
        render text: lines.flatten.join
      end
    end
  end

  private

  def clean(s)
    Iconv.conv('ASCII//IGNORE', 'UTF8', s.gsub(/[,"]/, '_'))
  end
end
