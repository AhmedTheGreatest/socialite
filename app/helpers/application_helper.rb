module ApplicationHelper
  def timeago(date, format: :long)
    return if date.blank?

    content = I18n.l(date, format: format)

    tag.time(content,
              title: content,
              data: {
                controller: 'timeago',
                timeago_datetime_value: date.iso8601
              })
  end
end
