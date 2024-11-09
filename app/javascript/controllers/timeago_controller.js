import { Controller } from "@hotwired/stimulus";

import dayjs from "dayjs"
import relativeTime from "dayjs/plugin/relativeTime";

dayjs.extend(relativeTime)

export default class extends Controller {
  isValid = true
  refreshTimer = 0

  static values = {
    datetime: String,
    refreshInterval: Number,
    addSuffix: Boolean,
  }

  initialize() {
    this.isValid = true
  }
  
  connect() {
    this.load()

    if (this.hasRefreshIntervalValue && this.isValid) {
      this.startRefreshing()
    }
  }

  disconnect() {
    this.stopRefreshing()
  }

  load() {
    const datetime = this.datetimeValue
    const date = Date.parse(datetime)
    
    if (Number.isNaN(date)) {
      this.isValid = false

      console.error(
        `Value given in 'data-timeago-datetime' is not a valid date (${datetime}). Please provide a ISO 8601 compatible datetime string. Displaying given value instead.`
      )
    }

    this.element.dateTime = datetime
    this.element.innerHTML = this.isValid ? dayjs(date).fromNow(this.addSuffixValue) : datetime
  }

  startRefreshing() {
    this.refreshTimer = setInterval(
      () => { this.load() }, 
      this.refreshIntervalValue
    )
  }

  stopRefreshing() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer)
    }
  }
}
