
#include "messages.host.h"
#include "messages.g.h"

#include "framework.h" 
#include <shobjidl.h>

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

	void QuantumHostApiImpl::SendMessage(const std::string& message, std::function<void(ErrorOr<bool>reply)> result)
	{
		result(ErrorOr<bool>{true});
	}
	/*void QuantumHostApiImpl::SendMessageW(const std::string& message, std::function<void(ErrorOr<bool>reply)> result)
	{
		result(ErrorOr<bool>{true});
	}*/

	ErrorOr<std::optional<DirectoryResponse>> QuantumHostApiImpl::ChooseDirectory()
	{

		
		return ErrorOr<std::optional<DirectoryResponse>>{std::nullopt};
	}

	ErrorOr<std::optional<std::string>> QuantumHostApiImpl::StartAccessingSecurityScopedResource(
		const std::string& bookmark_string)
	{
		return ErrorOr<std::optional<std::string>>{std::nullopt};
	}
}
