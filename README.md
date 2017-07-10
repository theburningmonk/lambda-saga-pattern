# lambda-saga-pattern

Implements the Saga pattern for Lambda functions using Step Functions.

The example is based on Catie McCaffrey's example in her talk on [Applying the
Saga pattern](https://www.youtube.com/watch?v=xDuwrtwYHu8).

Each request has a compensating request for rollback.

The Saga goes like this:

```
Begin saga
  Start book hotel request
  End book hotel request
  Start book flight request
  End book flight request
  Start book car rental request
  End book car rental request  
End saga
```

We'll need a transaction log for the saga, and Step Functions would be our
coordinator for the saga.

Because the compensating requests can also fail so we need to be able to retry
them until success, which means they have to be **idempotent**.

This demo implements **backward recovery** only.

For *forward recovery* you also need to ensure the requests are imdempotent.