# Trading App (Flutter)

Premium dark-mode crypto trading terminal scaffold with:

- Riverpod state management
- Simulated exchange ticker + candle feed (WebSocket-ready architecture)
- Dashboard with chart, spread, sticky trade actions
- Order panel with integrated risk calculator
- Position management with live PnL + SL/TP adjustments
- Demo/Live account mode toggle

## Run

```bash
flutter pub get
flutter run -d android
```

## Structure

- `lib/core`: theme/design system
- `lib/features/market`: exchange abstraction + simulated feeds
- `lib/features/trading`: models, risk logic, order + positions UX
- `lib/features/account`: mode toggle and balance editing
- `lib/shared`: reusable widgets

## Next Integrations

- Implement `ExchangeService` for Binance/Bybit REST + WebSocket.
- Replace simulated candle feed with actual kline stream.

Repository: https://github.com/scorling/trading-app
