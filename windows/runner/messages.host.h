#include "messages.g.h"

namespace quantum
{

	class QuantumHostApiImpl : public QuantumHostApi
	{
	public:
		QuantumHostApiImpl();
		ErrorOr<std::string> GetHostLanguage() override;
		ErrorOr<int64_t> Add(
			int64_t a,
			int64_t b) override;
		void SendMessage(
			const MessageData& message,
			std::function<void(ErrorOr<bool> reply)> result) override;
	};
}

