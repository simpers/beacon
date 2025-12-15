# Test Failures (post Tailwind v4 upgrade)

Reproduced with:

```sh
mix test
```

## 1) `Beacon.MediaLibraryTest` multipart S3 upload stub

- Failing test: `test/beacon/media_library_test.exs:30` (`"upload asset, converts to webp by default, s3 store"`)
- Symptom: crash from XML parsing: `{:fatal, {:expected_element_start_tag, ...}}` coming from `ExAws.S3.Parsers.parse_complete_multipart_upload/1`.
- Root cause: the Bypass stub returns an empty body for the multipart *complete* request (`POST ...?uploadId=...`), but `ex_aws_s3` expects an XML response body for `CompleteMultipartUpload`.

**Steps to fix**

1. Update `test/support/bypass_helpers.ex:18` (the clause matching `POST` + `uploadId`) to return a valid `CompleteMultipartUploadResult` XML body instead of `""`.
2. Keep status `200` and ensure the XML includes at least `<Bucket>`, `<Key>`, and `<ETag>` (and optionally `<Location>`), using the same `xmlns="http://s3.amazonaws.com/doc/2006-03-01/"` namespace used in the initiate response.
3. Re-run the focused test:

   ```sh
   mix test test/beacon/media_library_test.exs:30
   ```

4. Re-run the full suite:

   ```sh
   mix test
   ```
