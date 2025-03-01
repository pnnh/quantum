
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

	std::string PWSTRToString(PWSTR pwsz) {
		// 获取所需的缓冲区大小
		int bufferSize = WideCharToMultiByte(CP_UTF8, 0, pwsz, -1, NULL, 0, NULL, NULL);
		// 分配缓冲区
		std::string str(bufferSize, 0);
		// 将宽字符字符串转换为多字节字符串
		WideCharToMultiByte(CP_UTF8, 0, pwsz, -1, &str[0], bufferSize, NULL, NULL);
		return str;
	}

	ErrorOr<std::optional<DirectoryResponse>> QuantumHostApiImpl::ChooseDirectory()
	{

		// 初始化COM
		HRESULT hr = CoInitializeEx(NULL, COINIT_APARTMENTTHREADED |
			COINIT_DISABLE_OLE1DDE);

		if (FAILED(hr))
		{
			return ErrorOr<std::optional<DirectoryResponse>>{std::nullopt};
		}
		std::string resultString;
		IFileOpenDialog* pFileOpen;

		// Create the FileOpenDialog object.
		hr = CoCreateInstance(CLSID_FileOpenDialog, NULL, CLSCTX_ALL,
			IID_IFileOpenDialog, reinterpret_cast<void**>(&pFileOpen));

		DWORD options;
		hr = pFileOpen->GetOptions(&options);
		if (FAILED(hr))
		{
			pFileOpen->Release();
			CoUninitialize();
			return ErrorOr<std::optional<DirectoryResponse>>{std::nullopt};
		}

		options &= ~FOS_FILEMUSTEXIST;
		options &= ~FOS_PATHMUSTEXIST;
		hr = pFileOpen->SetOptions(options | FOS_PICKFOLDERS);
		if (FAILED(hr))
		{
			pFileOpen->Release();
			CoUninitialize();
			return ErrorOr<std::optional<DirectoryResponse>>{std::nullopt};
		}

		if (FAILED(hr))
		{
			pFileOpen->Release();
			CoUninitialize();
			return ErrorOr<std::optional<DirectoryResponse>>{std::nullopt};
		}
		// Show the Open dialog box.
		hr = pFileOpen->Show(NULL);

		if (FAILED(hr))
		{
			pFileOpen->Release();
			CoUninitialize();
			return ErrorOr<std::optional<DirectoryResponse>>{std::nullopt};
		}

		IShellItem* pItem;
		hr = pFileOpen->GetResult(&pItem);
		if (FAILED(hr))
		{
			pFileOpen->Release();
			CoUninitialize();
			return ErrorOr<std::optional<DirectoryResponse>>{std::nullopt};
		}

		PWSTR pszFilePath;
		hr = pItem->GetDisplayName(SIGDN_FILESYSPATH, &pszFilePath);
		 
		if (SUCCEEDED(hr))
		{
			//MessageBoxW(NULL, pszFilePath, L"File Path", MB_OK);
			resultString = PWSTRToString(pszFilePath);
			CoTaskMemFree(pszFilePath);
		}
		pItem->Release();

		pFileOpen->Release();
		CoUninitialize();

		auto dirResp = DirectoryResponse();
		dirResp.set_absolute_url(resultString);

		return ErrorOr<std::optional<DirectoryResponse>>{dirResp};
	}

	ErrorOr<std::optional<std::string>> QuantumHostApiImpl::StartAccessingSecurityScopedResource(
		const std::string& bookmark_string)
	{
		return ErrorOr<std::optional<std::string>>{std::nullopt};
	}
}
