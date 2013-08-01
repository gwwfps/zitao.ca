(fn [doc]
  (if (identical? doc.page true)
    nil
    (emit doc.timestamp doc)))