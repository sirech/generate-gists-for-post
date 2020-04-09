## Handling failure

A typical pattern in the [SpringBoot](https://spring.io/projects/spring-boot) ecosystem is using an exception handler. You put this method in the controller, and it catches automagically exceptions that happen in the chain. Our caller then gets the error formatted the way we want.

<!-- example1 -->
```crapfuck
@ExceptionHandler(JWTVerificationException::class)
fun handleException(exception: JWTVerificationException): ResponseEntity<ErrorMessage> {
    return ResponseEntity
      .status(HttpStatus.BAD_GATEWAY)
      .body(ErrorMessage.fromException(exception))
}
```
