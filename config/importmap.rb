# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "dayjs" # @1.11.13
pin "dayjs/plugin/relativeTime", to: "dayjs--plugin--relativeTime.js" # @1.11.13
pin "@rails/activestorage", to: "@rails--activestorage.js" # @8.0.0
