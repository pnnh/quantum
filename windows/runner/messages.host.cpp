
#include "messages.host.h"
#include "messages.g.h"

namespace quantum
{
	QuantumHostApiImpl::QuantumHostApiImpl() : QuantumHostApi()
	{
	}

	ErrorOr<std::string> QuantumHostApiImpl::GetHostLanguage()
	{
		return ErrorOr<std::string>{"C++"};
	}

	ErrorOr<int64_t> QuantumHostApiImpl::Add(
		int64_t a,
		int64_t b)
	{
		return ErrorOr<int64_t>{a + b};
	}

	void QuantumHostApiImpl::SendMessage(
		const MessageData& message,
		std::function<void(ErrorOr<bool> reply)> result)
	{
		result(ErrorOr<bool>{true});
	}


}
